import * as pulumi from "@pulumi/pulumi";
import * as aws from "@pulumi/aws";
import * as awsx from "@pulumi/awsx";

const config = new pulumi.Config();

const repository = new awsx.ecr.Repository("sv2-tp", {
  name: "sv2-tp",
});

const image = new awsx.ecr.Image("sv2-tp", {
  repositoryUrl: repository.url,
  context: "../",
  // `imageTag` is designed to be passed in as a command line parameter using the `-c` flag.
  // This flag automatically updates the local configuration file at `Pulumi.production.yaml`
  // for example, so take care not to commit it when testing locally. Changes to this file are
  // ignored during CI/CD runs.
  imageTag: config.require("imageTag"),
});
