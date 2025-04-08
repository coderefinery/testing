# Instructor guide

## Why we teach this lesson

- Because writing tests and using automated testing is often part
  of the development process, especially for codes that are larger than
  a simple script.
- We wish to give learners the tools so that they can rewrite codes and
  collaborate on a code projects with more confidence.
- Testing can help detecting regressions during development instead of later
  (when using the code) or too late (after having published results).
- Can simplify collaboration since contributors can be more confident that
  their changes preserve expected functionality.
- Tests document the intent of the function/module/library/code.
- Tests can guide the code towards more modular and reusable code style with
  fewer side effects.


## Intended learning outcomes

- Know that in each language tools exist that can execute a series of test functions
  and report success or failure.
- Know that services like GitHub Actions, Azure pipelines, GitLab CI, Appveyor, and others
  allow us to automatically run tests on every Git push or every pull request or merge request.
- Be able to approach a function or module or library and design a test for it "in words"
  or pseudo-code.
- Know what test coverage means and how it can help to detect untested/unused code.
- Know where in a larger and untested project to start introducing tests since it is beyond
  reach and also probably not reasonable to test everything.


## How we teach this lesson

### How to start

The quote from another testing lesson by Kathryn Huff can be discussed
to get participants to reflect on the role of software testing in
science and its parallels to calibrating measurement devices. The second half
of the quote is left out because it goes so far as to say that untested software
does not constitute science, and this can be offending to learners.

### Questions to involve participants

- Do you agree that testing software is similar to calibrating detectors?
- Do you test your code?
- How and when do you test?
- Where would you start adding a test in an existing project?
- In which situations would you recommend not to add any tests?


### Structure of the lesson

#### Concepts

After the Motivation episode, the lesson continues with a walkthrough
of important concepts in software testing (unit tests, integration
tests, test-driven development etc). At the end of the Concepts episode
there's a link to the Quick Reference where learners can find a list of
available testing frameworks for different languages.

#### Testing locally

After introducing the concepts the lesson becomes hands-on in the
Testing Locally episode. The pytest example there can be done as
type-along and the optional exercise "Testing with numerical
tolerance" can be left as homework.

#### Automated testing (or full-cycle collaborative workflow)

After learning how to run tests locally, the lesson goes into
automated testing using GitHub Actions or GitLab CI in the Automated
Testing episode. This episode is a simplified version of the
collaborative exercise in the optional episode "Full-cycle
collaborative workflow", and the instructor has a choice which one to
teach (with the latter requiring around double the time). The
exercise in Automated Testing can either be done as a type-along
demonstration by the instructor or as an exercise in breakout rooms.  

**If run as an exercise, this episode requires that learners know how
to set up Git repositories locally and online and how to work with
pull/merge requests!**

If the optional Full-cycle episode is covered, it is useful during the
wrap up of the exercise to have a co-instructor doing the exercise in
parallel with you. As your partner makes a pull requests with "fixes
#1" (or whatever PR number) you can show that the PR links to a issue,
and the issue pointing to a commit.

#### Test design

This episode now has exercises in different languages covering
different testing approaches (unit tests, integration tests, testing
randomness, TDD). In normal workshops there are far too many
exercises for the available time so the instructor has freedom to
recommend specific exercises, to let learners choose themselves, or to
recommend learners to discuss rather than implement the tests.

#### Order of Continuous Integration and Test Design

When this lesson is taught standalone in a software testing workshop
or hackathon, it might be better to go through the Test Design episode
before the Continuous Integration episode.

### Timing

The lesson is stipulated to take around 2 hours, but if more time is
available you can replace the Automated Testing episode with "Full-cycle 
collaborative workflow", or give more time to the Test Design episode.

Splitting the lesson in two halves with a lunch break in the middle
works well. Before lunch you have on hour introduction and the two
first exercises. After lunch you continue with the automated testing 
exercise and test design.

### Room for improvement

- The lesson is still too Python centric in the "Testing locally" and "Automated testing" episodes.
  It would be nice to offer alternatives for learners who write in different languages.
- Currently the lesson is in the "discipline" domain. Testing is
  something you do to control behavior (your own as well as the code).
  Testing is also something you can do to improve productivity, but this
  is less visible/detectable.
