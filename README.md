This repository demoes several projects that are versioned in one git
repository. This setup is not so common with git that often takes the
aproach to have smaller repos, but would still be an option to ease
continuous integration.

In this case, I would clone this repository to a specific location and
import the seperate projects independently in my IDE (IntelliJ or Eclipse)

How to play with it

### Clone Repo from Github and create a local bare repository

    git clone https://github.com/rattermeyer/demo-cd-version.git
    mkdir demo-cd-version.git
    cd demo-cd-version
    git remote rm origin
    git remote add origin /path/to/demo-cd-version.git

### Update your build Jobs
The build jobs are located under ci-simulator.
There are currently two jobs:

* independent-utility
* multi-module

Each job contains job.properties.
Edit the job properties and adjust `BUILD_NUMBER` and `GIT_URL`.
`GIT_URL` should point to your created local repo, e.g.
`GIT_URL=/path/to/demo-cd-version.git`

and commit and push your repo

    git commit -am "updated build jobs"
    git push origin master

### Install demo-parent
Inside the project:

    cd demo-parent
    mvn install

### Execute Builds

    cd ci-simulator/independent-utility
    ./build.sh

This might create and install a jar with a specific version. The Version has a format like
`1.1.6-086aac3`

### Add the dependency to multi-module    
Edit `multi-module/pom.xml`

And change the version attribute in the dependency mgmt section to the new version.

    <dependency>
         <groupId>de.rattermeyer.demo</groupId>
         <artifactId>independent-utility</artifactId>
         <version>1.1.3-b09255d</version>
    </dependency>

And commit and push your changes

    git commit -am "updated dependencies"
    git push origin master

### Build the multi-module project

   cd ci-simulator/multi-module
   ./build.sh
