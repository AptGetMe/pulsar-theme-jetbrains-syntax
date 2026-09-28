import { createPrompt, presets } from "@toiroakr/read-multiline"

import { spawn } from "child_process"
import { parseArgs } from "util"

const { values: args } = parseArgs({ 
    strict: false,
    options: { 
        test: { type: "boolean", short: "t" } 
    }
})
if (args.test) { 
    console.log("> release test mode enabled\n") 
}

const ask = createPrompt(presets.inquirer)

const [token, err] = await ask("Github Token:  ", { 
    inlinePrompt: true, 
    initialValue: args.test === true ? "dummy_token" : undefined,
    validate: (v) => (v.trim() === "" ? "Input cannot be empty" : undefined)
})
if (err) {
    console.log(err.message)
    process.exit(1)
}

let cmd = ["release-it"]
if (args.test) {
    cmd = ["release-it", "--dry-run", "--no-git.requireCleanWorkingDir"]
}

const release = spawn("npx", cmd, {
    stdio: "inherit",
    shell: true,
    env: { ...process.env, GITHUB_TOKEN: token }
})

release.on("close", (code) => {
    process.exit(code)
})
