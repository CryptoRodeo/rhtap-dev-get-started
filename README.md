# RHTAP Developer Onboarding

## Table of Contents
- [Basic Information](#basic-information)
  - [Our Plugins](#our-plugins)
  - [Plugin Distribution](#plugin-distribution)
  - [Community Collaboration](#community-collaboration)
  - [Communication Channels](#communication-channels)
- [Learning Resources](#learning-resources)
  - [Basic Concepts](#basic-concepts)
  - [Hands-on Exercises](#hands-on-exercises)
- [Getting Access](#getting-access)
  - [Becoming a Plugin Maintainer](#becoming-a-plugin-maintainer)
- [Your Responsibilities](#your-responsibilities)
- [Creating Pull Requests](#creating-pull-requests)
- [Testing](#testing)
  - [RHDH Testing](#rhdh-testing)
- [Helpful Links](#helpful-links)
  - [Languages and Libraries](#languages-and-libraries)

## Basic Information

### Our Plugins
We maintain these plugins in the Backstage community:
- [Multi Source Security Viewer](https://github.com/backstage/community-plugins/tree/main/workspaces/multi-source-security-viewer)
- [Quay](https://github.com/backstage/community-plugins/tree/main/workspaces/quay)
- [Red Hat ArgoCD](https://github.com/backstage/community-plugins/tree/main/workspaces/redhat-argocd)
- [Tekton](https://github.com/backstage/community-plugins/tree/main/workspaces/tekton)

We don't maintain these plugins, but we do add features when needed:
- [Jenkins](https://github.com/backstage/community-plugins/tree/main/workspaces/jenkins)
- [Azure Devops](https://github.com/backstage/community-plugins/tree/main/workspaces/azure-devops)

### Plugin Distribution
We distribute our plugins as **OCI artifacts** that get loaded into RHDH.

The system that generates and distributes these plugins is currently being developed.

#### What is an OCI artifact?
An **OCI artifact** is a package format that follows the Open Container Initiative (OCI) standard. It allows us to:

- Store and distribute software and related files using container registries (like Quay)
- Maintain compatibility across different tools and platforms
- Package various types of content beyond just containers (such as our plugins)

Think of it like a standardized box that can hold different types of items, making them easier to ship and use across different systems.

### Community Collaboration
The Backstage repository is open source and not owned by Red Hat. This means:
- You'll work with Spotify developers and other external contributors
- PR reviews may depend on external developers' schedules
  - Some reviewers have set "office hours" that are not in-line with our plans(e.g., only reviewing PRs on Fridays)
- You'll need to monitor open Github issues related to our plugins
	- Create Jira issues for these Github issues to track the work

### Communication Channels
You can join the Backstage community channels listed here: https://github.com/backstage/community?tab=readme-ov-file#backstage-community
They use Discord as their main communication channel.

You can also add their community meetings to your Google calender, but there's no expectation to join these meetings.

## Learning Resources

### Basic Concepts
Before diving into development, understand:
- [What is Backstage and its purpose](https://backstage.spotify.com/learn/backstage-for-all/)
- [What is RHDH (Red Hat Developer Hub)](https://github.com/redhat-developer/rhdh?tab=readme-ov-file#purpose)

### Hands-on Exercises
Get practical experience with:
- [Running Backstage locally](https://backstage.spotify.com/learn/standing-up-backstage/)
- [Introduction to Plugins](https://backstage.io/docs/plugins/)
- [Adding a plugin to your Backstage instance](https://github.com/backstage/community-plugins/tree/main/workspaces/quay/plugins/quay#installation)

## Getting Access

### Becoming a Plugin Maintainer
Follow these steps to become a plugin maintainer:
1. Get added to the `CODEOWNERS` file for our specific plugins
   - Example: [See this PR](https://github.com/backstage/community-plugins/pull/2094)
2. Request permission to be added as a plugin maintainer
   - Create an issue using [this template](https://github.com/backstage/community/issues/206)
   - Select Option 3 (plugin maintainer)
   - Include a link to your `CODEOWNERS` PR
   - Be patient - the review process can take time

## Your Responsibilities
As a plugin maintainer, you'll need to follow the guidelines outlined here:
https://github.com/backstage/community-plugins/blob/main/docs/plugin-maintainers-guide.md

## Creating Pull Requests
When submitting changes:
1. [Generate a changeset](https://github.com/backstage/community-plugins/blob/main/CONTRIBUTING.md#creating-changesets)
   - Refer to [semantic versioning](https://semver.org/) to determine the correct bump-type
2. Complete as much of the [PR checklist](https://github.com/backstage/community-plugins/blob/main/CONTRIBUTING.md#submitting-a-pull-request) as possible

## Testing

### Running local instances of X application
- [ArgoCD](./ArgoCD/README.md)
- [Jenkins](./Jenkins/README.md)
- [Tekton](./Tekton/README.md)

### RHDH Testing
Ensure your plugins work correctly with RHDH using these tools:
- Set up a local RHDH instance: https://github.com/redhat-developer/rhdh-local
- Create and load OCI artifacts for your plugin: https://github.com/redhat-developer/rhdh/blob/main/docs/dynamic-plugins/index.md#installing-external-backstage-plugins-into-rhdh

## Helpful Links

### Languages and Libraries
Resources for the technologies we use:
- [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- [PatternFly Component Library](https://www.patternfly.org/)
- [Material-UI (MUI) Component Library](https://mui.com/)
