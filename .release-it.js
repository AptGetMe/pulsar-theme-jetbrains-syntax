const { readMultiline } = require("@toiroakr/read-multiline")

module.exports = {
  $schema: "https://unpkg.com/release-it@20/schema/release-it.json",
  git: {
    changelog: "npx auto-changelog --stdout --commit-limit false -u --template https://raw.githubusercontent.com/release-it/release-it/main/templates/changelog-compact.hbs",
    requireCleanWorkingDir: true,
    commit: true,
    commitMessage: "chore: release v${version}",
    tag: true,
    tagName: "v${version}",
    tagAnnotation: "Release tag",
    push: true,
    pushArgs: ["--follow-tags"]
  },
  github: {
    release: true,
    releaseName: "Release Theme Jetbrains v${version} ! ! !",
    releaseNotes: async (context) => {
      const [msg, err] = await readMultiline("Enter Release Notes:", {
        linePrefix: "> ",
        initialValue: "## Changes",
        theme: { 
          prompt: "bold",
          prefix: "cyan",
          linePrefix: "cyan"
        }
      })
      if (err) {
        console.log(err.message)
        process.exit(1)
      }
      const notes = [msg, context.changelog].join("\n\n")
      return notes
    }
  },
  npm: {
    publish: false
  },
  hooks: {
    "after:bump": "npx auto-changelog -p --sort-commits date --commit-limit false",
    "after:release": "pulsar -p publish --tag v${version}"
  }
}