# samizdat-plugin-template

A starting **template** for a new [Samizdat](https://samizdat.foundation) plugin
distribution — a minimal, working `Plugin` + `Controller` + `Model` trio with the
known-good packaging so you don't re-derive it (or re-hit the scaffolding bugs).

## What's here

    lib/Samizdat/Plugin/Skeleton.pm        register() + the `skeleton` helper
    lib/Samizdat/Controller/Skeleton.pm    a JSON/HTML index action
    lib/Samizdat/Model/Skeleton.pm         business logic / data access
    lib/Samizdat/resources/templates/skeleton/   index.html.ep + index.js
    lib/Samizdat/resources/settings/skeleton/schema.yml   JSON-Schema config contract
    lib/Samizdat/resources/migrations/pg/40-skeleton/1/{up,down}.sql   schema migration
    Makefile.PL          EUMM dist; File::Find PM map ships resources to site_perl
    t/00-load.t          loads the trio, checks resources + migration + schema audience
    .github/workflows/test.yml   CI: checks out core, installs deps, runs the tests
    new-plugin.sh        rename Skeleton -> YourName everywhere

## Use it

    ./new-plugin.sh Widget        # renames Skeleton/skeleton -> Widget/widget
    # edit Makefile.PL (NAME/ABSTRACT/PREREQ_PM), flesh out the model + migration,
    # set x-samizdat-audience, then commit.

## Conventions (don't relearn these the hard way)

- The migration is a **numbered-version-dir**: `migrations/pg/<NN>-<name>/<version>/{up,down}.sql`.
  `<NN>` orders schemas by cross-schema FK dependency (10 public → 20 account → 30 customer
  → 40 most things → 50 website → 60 web). New schema changes = a new version dir.
- Resources install under `Samizdat/resources/` and are found across `@INC` by core's
  resolver — the plugin pushes no paths.
- Keep DB queries in the model; controllers return JSON. Every page template is
  `<dir>/index.html.ep` (never a sibling like `show.html.ep`).
- Requires core **Samizdat** on `PERL5LIB` or installed (provides the settings
  resolver, `pg`/`mysql`/`cache` helpers).
