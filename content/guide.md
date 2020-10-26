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
- Know that services like GitHub Actions, Travis CI, GitLab CI, Appveyor, and others
  allow us to automatically run tests on every Git push or every pull request or merge request.
- Be able to approach a function or module or library and design a test for it "in words"
  or pseudo-code.
- Know what test coverage means and how it can help to detect untested/unused code.
- Know where in a larger and untested project to start introducing tests since it is beyond
  reach and also probably not reasonable to test everything.


## How we teach this lesson

### How to start

Every one know tests and do testing is a good thing. But do we stick to
this? The motivation part start with a very strong claim, which put our
non-tested code in the domain of "not science". It is interesting to get
views from the participants on the citation of Anthony Scopatz and
Kathryn Huff.


### Questions to involve participants

- What do you think about the statement "Simulations and analysis with
  untested software do not constitute science."?
- Do you test your code?
- How and when do you test?
- Where would you start adding a test in an existing project?
- In which situations would you recommend not to add any tests?


### Structure of the lesson

The lesson then continues with:
- Motivate verification of functionality
- Motivate tests as a way of documenting use
- Motivate tests as a support for further code development

We illustrate how tests can be done in various ways. Tests can be part
of code.  It can be used as a check during a git commit. It can be set
up automatically such that Pull Requests get verified by a Continuous
Integration service like Travis.

The examples work quite well. The pytest example can be done as type
along. During the wrap up of the example with GitHub Actions, it is useful to
have co-instructor doing the exercise in parallel with you. As your
partner write pull requests with "fixes #1" (or whatever PR number) you
can show that the PR links to a issue, and the issue pointing to a
commit.


### Timing

The lesson is stipulated to take 2 hours and 10 minutes. If the "Tools"
and "Test Design" is skipped the lesson can shrink to a length of 90
minutes.

Splitting the lesson in two halves with a lunch break in the middle
works very well. Before lunch you have on hour introduction and the two
first exercises. After lunch you continue with the collaborative testing
exercise and test design.

The full introduction (motivation, concepts, and tools) can take 30 minutes and
that is a too long intro so the instructor needs to select and make clear that
material contains more than we wish to cover in a lesson.

When discussing the list of tools, one can just show the list, but not dive in
to the specifics. The participants know where to look if they a specific
interest.

The last exercise/discussion on test design has often been skipped.
However, if there is time for group work and the groups have some Python experience,
this episode can make for very good discussions.


### Room for improvement

- The lesson is too Python centric. It would be nice to offer more
  for learners who write in different languages (like R or C++).
- Currently the lesson is in the "discipline" domain. Testing is
  something you do to control behavior (your own as well as the code).
  Testing is also something you can do to improve productivity, but this
  is less visible/detectable.
- The lesson should give a more balanced view also about situations where
  automated testing is not needed.
- We have a test design episode but often skip it but we leave learners then
  without having practices how to approach testing in an existing project.
