# Tools procedures

## Tool sections

We will grep out the `<section>` tags and the `<label>` tags from https://github.com/usegalaxy-eu/galaxy-playbook-temporary/blob/master/roles/galaxy_config/templates/tool_conf.xml

And add them to our `tool_conf.xml` file, and then make sure that our `shed_tools_conf.xml` & `tool_conf.xml` files refer to the correct category names.

## Tool consolidation

In the first instance we will use tool yaml files from the https://github.com/usegalaxy-au/usegalaxy-eu-tools repo. We will install most of these files except for the proteomics and metabolomics files. We will use the `.lock` files.

Old conf files will be kept as per Mike's procedure.

### Future considerations

* We will have a joint usegalaxy.* location for these files somewhere on github.
* These files will have a procedure for change that includes PRs and reviews.
* We will implement a system where the files are pulled, then ran on a weekly or so basis automatically to keep the usegalaxy.* systems in sync.
* Local tools will be kept in yaml files in the usegalaxy-au repos.

## Tool policy

* Simon, Derek and others to write a tool installation policy for new tools.
    * Things to consider include - testing tools before installation on main.
    * Tool use frequency
    * Does it need to be wrapped
    * Test data - get requesting user to supply some test data (unless it exists in the toolshed), then send them output of tool run with data for them to check before we install it on main.
    * Which project is it for?
    * Can it be incoporated into a workflow and are there already alternatives to this tool?
