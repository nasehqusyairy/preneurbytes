import { readFileSync, writeFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import ts from "typescript";

const packageDirectory = fileURLToPath(new URL("../", import.meta.url));
const databaseTypesPath = new URL("../src/database.types.ts", import.meta.url);
const modelsPath = new URL("../src/models.ts", import.meta.url);
const sourceText = readFileSync(databaseTypesPath, "utf8");
const sourceFile = ts.createSourceFile(
    databaseTypesPath.pathname,
    sourceText,
    ts.ScriptTarget.Latest,
    true,
    ts.ScriptKind.TS,
);

function propertyName(property) {
    if (ts.isIdentifier(property) || ts.isStringLiteral(property)) {
        return property.text;
    }
    return undefined;
}

function findProperty(typeNode, name) {
    if (!ts.isTypeLiteralNode(typeNode)) return undefined;
    return typeNode.members.find(
        (member) =>
            ts.isPropertySignature(member) && propertyName(member.name) === name,
    );
}

const databaseDeclaration = sourceFile.statements.find(
    (statement) =>
        ts.isTypeAliasDeclaration(statement) && statement.name.text === "Database",
);
if (!databaseDeclaration) {
    throw new Error("Could not find the generated Database type.");
}

const publicSchema = findProperty(databaseDeclaration.type, "public")?.type;
const tablesType = publicSchema && findProperty(publicSchema, "Tables")?.type;
if (!tablesType || !ts.isTypeLiteralNode(tablesType)) {
    throw new Error("Could not find public tables in the generated Database type.");
}

function toPascalCase(name) {
    return name
        .split(/[^a-zA-Z0-9]+/)
        .filter(Boolean)
        .map((part) => part[0].toUpperCase() + part.slice(1))
        .join("");
}

function singularize(name) {
    if (/ies$/i.test(name)) return name.replace(/ies$/i, "y");
    if (/(ches|shes|sses|xes|zes)$/i.test(name)) {
        return name.replace(/es$/i, "");
    }
    if (/s$/i.test(name) && !/(ss|us|is)$/i.test(name)) {
        return name.slice(0, -1);
    }
    return name;
}

const aliases = [];
const usedNames = new Set();
for (const table of tablesType.members) {
    if (!ts.isPropertySignature(table)) continue;
    const tableName = propertyName(table.name);
    if (!tableName) continue;

    const pluralName = toPascalCase(tableName);
    const singularName = toPascalCase(singularize(tableName));
    for (const modelName of new Set([pluralName, singularName])) {
        if (usedNames.has(modelName)) {
            throw new Error(`Table names produce a duplicate model alias: ${modelName}`);
        }
        usedNames.add(modelName);
        aliases.push(
            `export type ${modelName} = Database["public"]["Tables"]["${tableName}"]["Row"];`,
            `export type ${modelName}Insert = Database["public"]["Tables"]["${tableName}"]["Insert"];`,
            `export type ${modelName}Update = Database["public"]["Tables"]["${tableName}"]["Update"];`,
        );
    }
}

if (aliases.length === 0) {
    throw new Error("No public tables were found in the generated Database type.");
}

const output = [
    'import type { Database } from "./database.types.js";',
    "",
    'export type TableName = keyof Database["public"]["Tables"];',
    'export type TableRow<Name extends TableName> = Database["public"]["Tables"][Name]["Row"];',
    'export type TableInsert<Name extends TableName> = Database["public"]["Tables"][Name]["Insert"];',
    'export type TableUpdate<Name extends TableName> = Database["public"]["Tables"][Name]["Update"];',
    "",
    ...aliases,
    "",
].join("\n");

writeFileSync(modelsPath, output);
console.log(`Generated model aliases for ${tablesType.members.length} public tables in ${packageDirectory}.`);