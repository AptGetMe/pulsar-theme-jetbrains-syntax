# Internal Maintainence for Project Owner

Only applies to the project owner, me 😋.
I didn't know where else to put this, and if I don't write it down, I might forget how I set this up.

## How Releases and Package Updates Work

Uses [Release-It](https://www.npmjs.com/package/release-it) to automate bumping versions, creating changelogs, tags and release notes.  It intergrates with the manual [pulsar package publishing system](https://docs.pulsar-edit.dev/developing-for-pulsar/maintaining-your-package/#publishing-a-package-manually).

- create github classic token

- login to [pulsar packages](https://packages.pulsar-edit.dev/login) with token

- update a ```.env``` file with the current github token genereated for the repo.  

- run ```npm run release```

An example use is in the file ```.env.example```.  \
It's important that .env file is ignored by git with .git-ignore.  \
Never store github token in git!
