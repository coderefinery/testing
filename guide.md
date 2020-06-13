---
layout: default
permalink: /guide/
---

# Instructor guide

## Why we teach this lesson


## Intended learning outcomes
* To learn and get a feel of Travis.
* Testing serve different purposes.
* There are different type of tests
* Tests can be challenging, but test help reveal intentions.


## Discussion

We illustrate how tests can be done in various ways. Tests can be part
of code.  It can be used as a check during a git commit. It can be set
up automatically such that Pull Requests get verified by a Continuous
Integration service like Travis.

The lesson covers a lot of aspects related to testing. It tilt some what
towards testing with the purpose of software shipping. When testing with
the purpose of verification and behavior specification is emphasized it
becomes better and more well received.

Currently the lesson is in the "discipline" domain. Testing is
something you do to control behavior (your own as well as the code). 
Testing is also something you can do to improve productivity, but this 
is less visible/detectable.


## How to teach this lesson

### How to start
Every one know tests and do testing is a good thing. But do we stick to
this? The motivation part start with a very strong claim, which put our
non-tested code in the domain of "not science". It is interesting to get
views from the participants on the citation of Anthony Scopatz and 
Kathryn Huff.

The lesson then continues with:
- Motivate verification of functionality
- Motivate tests as a way of documenting use
- Motivate tests as a support for further code development

These are valid points, but does not move "Testing" from the domain of
something "we should do", to the domain of "what we always do". This is
currently a weakness of the lesson (a point for discussion).

The examples work quite well. The pytest example can be done as type
along. During the wrap up of the example with Travis, it is useful to
have co-instructor doing the exercise in parallel with you. As your
partner write Pull Requests with "fixes #1" (or whatever PR number) you
can show that the PR links to a issue, and the issue pointing to a
commit.

### Questions to involve participants
* What do you think about the statement "Simulations and analysis with
  untested software do not constitute science."?
* Do you test?
* How and when do you test?

### Timing
The lesson is stipulated to take 2 hours and 10 minutes. If the "Tools"
and "Test Design" is skipped the lesson can shrink to a length of 90
minutes.

Splitting the lesson in two halves with a lunch break in the middle
works very well. Before lunch you have on hour introduction and the two
first exercises. After lunch you continue with "Automatic testing with 
Travis" and "Test Design".

### Sessions which can be skipped if time is tight
* The list of tools. One can just show the list, but not dive in to the
  specifics. The participants know where to look if they a specific
  interest.
* The exercise/discussion test design has often been skipped. If one split into
  groups with some python expertise in each group, the discussions are good though.

### Typical pitfalls
* The full introduction, which is Motivation + Concepts + Tools, is
  estimated to take 30 minutes. That is a very long intro!
* The lesson is very Python centric. We just assume what we say is
  transferable to another language, like R.
* Testing is done with different motivations. If you ship software, you
  do testing with the purpose of quality assurance (QA). As a developer
    you do testing for verifying behaviour. With
    Test-Driven-Development you specify behavior with tests. Writing
    software for research you want to verify/specify behavior, rather
    than do QA. 
* With the Travis setup you verify that behavior is preserved across
  versions and platforms. The motivation for using Travis is not
  necessarily for shipping software. 
