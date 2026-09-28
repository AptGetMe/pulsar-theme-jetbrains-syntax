import { createPrompt, presets } from "@toiroakr/read-multiline"
import { spawn } from "child_process"

const ask = createPrompt(presets.inquirer)

const [token, err] = await ask("Github Token:  ", { 
    inlinePrompt: true, 
    validate: (v) => (v.trim() === "" ? "Input cannot be empty" : undefined)
})
if (err) {
    console.log(err.message)
    process.exit(1)
}

const release = spawn("npx", ["release-it"], {
    stdio: 'inherit',
    shell: true,
    env: { ...process.env, GITHUB_PAT: token }
})

release.on("close", (code) => {
    process.exit(code)
})
