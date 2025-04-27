#!/bin/node
// Script for generating bash script for user interactive menu
// or script generating templates for template engine ;)

import fs from 'fs';

const templates = process.argv.slice(2);

for(let template of templates) {
    const td = JSON.parse(fs.readFileSync(template));
    var result = `
        #!/bin/bash

        bold=$(tput bold)
        normal=$(tput sgr0)
        filename=\$(basename "$0")
        filename="\${filename%.*}"

        clear
        echo "\${bold}=================| ${td.title} |=================\${normal}"
    `;

    const jinjaCr = [];

    for(let [groupId, group] of Object.entries(td.groups)) {
        result += `
            echo
            echo "\${bold}${group.title}\${normal}"
        `;

        for(let [fieldId, field] of Object.entries(group.fields)) {
            jinjaCr.push(fieldId);
            result += `
                echo "${field.text}${field.default != null ? ` [${field.default}]` : ``}:"
                read -p "> " ${fieldId}
                ${fieldId}=\${${fieldId}:-"${field.default != null ? field.default : ``}"}
            `;
        }
    }

    result += `
        echo
            echo Building from $filename.j2 to "$filename.rsc"

            jinja2 -o "$filename.rsc" "$filename.j2"
    `;
    result = result.replaceAll("    ", "");
    result = result.substring(1, result.length-2);

    for(let jnj of jinjaCr) {
        result += ` \\\n    -D ${jnj}=$${jnj}`;
    }

    fs.writeFileSync(template.replace(".json", ".sh"), result);
}