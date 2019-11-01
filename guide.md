---
layout: default
permalink: /guide/
---

# Instructor guide

## Why we teach this lesson

## Intended learning outcomes


## How to teach this lesson

### How to start

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
* Testing is done with different motivations. If you ship software, you
  do testing with the purpose of quality assurance (QA). As a developer
    you do testing for verifying behaviour. With
    Test-Driven-Developement you specify behavior with tests. Writing
    software for research you want to verify/specify behavior, rather
    than do QA. 
* With the Travis setup you verify that behavior is preserved across
  versions and platforms. The motivation for using Travis is not
  necessarily for shipping software. 
