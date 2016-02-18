The demo-parent is maven parent project just to demo some domain or
enterprise wide settings.

This project has no "SNAPSHOT" version and is released directly.

Things defined on this level are, e.g.

* Deployment Repositories

But no dependencies. Dependencies should be defined in the dependency management section of
the parent pom of a multi module build.