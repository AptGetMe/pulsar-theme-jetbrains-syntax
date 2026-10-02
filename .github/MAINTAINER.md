# Internal Maintainence for Project Owner

Only applies to the project owner, me 😋.
I didn't know where else to put this, and if I don't write it down, I might forget how I set this up.

## How Releases and Package Updates Work

Uses [Release-It](https://www.npmjs.com/package/release-it) to automate bumping versions, creating changelogs, tags and release notes.  It intergrates with the manual [pulsar package publishing system](https://docs.pulsar-edit.dev/developing-for-pulsar/maintaining-your-package/#publishing-a-package-manually) to automatically push the new package to Pulsar's package website after everything is ready.

Requires a Pulsar account and Pulsar API key.  I think this is a one time thing, however and never has to be repeated.

## Steps to Create New Release

1. Create github token
> [!TIP]
> If using a fine-grained token, make sure it has permissions to the repo and read-write contents

2. Run ```npm run release``` for final release or ```npm run release-test``` to test the whole release system to see what commands and actions will happen without actually commiting them.

3. Enter github token

> [!NOTE]
> Release-it may ask for the username and token again to authenticate git if git does not already have the credentials stored in it's environment.

4. Type release notes message which will be prependend to the automatically generated changelog notes.

5. Follow release-it prompts