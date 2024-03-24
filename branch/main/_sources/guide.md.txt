# Instructor guide

## Detailed schedule

- 9:00-9:15 [Motivation](https://coderefinery.github.io/testing/motivation/)
- 9:15-9:40 [Testing locally](https://coderefinery.github.io/testing/pytest/)
    - explain the exercise: 5 min
    - **20 min exercise**
- 9:40-10:00 [Automated testing](https://coderefinery.github.io/testing/continuous-integration/)
    - demo
- 10:00-10:10 Break
- 10:10-10:50 [Test design](https://coderefinery.github.io/testing/test-design/)
    - explain the exercise: 10 min
    - **20 min exercise**
    - discussion and type-along of advanced exercises: 10 minutes
- 10:50-11:00 Discussion and summary


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

#### Motivation and concepts

The former "motivation" and "concepts" episodes have been combined
into one.  Previously, the lesson was described as quite dogmagtic and
without enough time for exercises.  When teaching, try to give some of
the benefits, but without being too long about it.  The quick
reference has more details on language-specific things.

#### Testing locally

After introducing the concepts the lesson becomes hands-on in the
Testing Locally episode. The pytest example there can be done as
type-along and the optional exercise "Testing with numerical
tolerance" can be left as homework.  The end-to-end test may be hard
for many people who can't script other programs, but it provides
something that can keep advanced people interested for longer.

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



## Field reports

### 2024 March (first time with no exercises)

This was the first year we did the "all demo" mode with no exercises,
and it worked well enough.  Our rough plan can be seen [at this
hackmd](https://hackmd.io/cMowYt5nQOqZj0n1wsIlyw) (not pasted here
because it's kind of long).

We tried to be fast with motivation, and not go to details. In
"testing locally", we basically did the exercise as a demo.  There
wasn't much of note, it worked and there was plenty of
discussion. "Automated testing" worked fine also, except: a) we had to
choose how to push to Github, we used vscode, but not all learners did
that method.  Nothing to change here, but be aware you should explain
what and why you are doing for people who didn't use your chosen
method of linking, and b) code coverage didn't work from a PR from a
fork.  We had one person set up the automated tests, then swapped
instructors and showed the second making the fork and contributing.

The biggest thing to think about is how, when demoing testing
locally/automated testing, people ask "how to tests work?", which then
comes later.  I don't know if I would change the order,
though... because showing how to design tests without knowing how to
use them would make the same kind of questions, but reversed.  I think
it's just a "decide how it is and prepare for the questions" - maybe
in "motivation" or some other summary episode at the start.

"Test design" didn't have any major problems, but many of the tests
were relatively simple to discuss: the earlier tests would be trivial
to understand if someone shows you the code (should we demonstrate
typing two lines that's the same as in motivation? - but interesting
to do as an exercise).  Some of the later ones were interesting to
build up and demonstrate.  It would be good to think which exercises
one wants to demo, and which one wants to only talk about.  And think
which comes out of each demo/telling.

Overall, no major issues in doing this demo-based with good
familiarity but limited preparation time.


### 2023 September

For this lesson, "Motivation" and "Concepts" were combined.  An extra
end-to-end test was added under "testing locally".


### 2023 March

Due to a mix-up with instructors, we changed the plan at the last
minute and it didn't go so well (we should have known).  The original
plan had pytest as a demo, with exercises for Github CI and test
design.  We did pytest as an exercise, Github CI as an exercise, and
had almost no time for test design.  One complaint was that there
wasn't enough time for practical things, so I think a plan like last
time could have been good.  As usual, we should have found a way to
talk less and do more.

This was the schedule from March 2023:

```markdown
* 8:50 - 9:00 Getting started
* 9:00 - 10:45 [Software testing](https://coderefinery.github.io/testing/)
  - 9:00-9:05 Short info about today's exercise sessions and possible questions from yesterday
  - 9:05-9:10 [Motivation](https://coderefinery.github.io/testing/motivation/)
  - 9:10-9:20 [Concepts](https://coderefinery.github.io/testing/concepts/)
  - 9:20-9:45 [Testing locally](https://coderefinery.github.io/testing/pytest/)
      - 5 minutes talking
      - 15 minute exercises
      - 5 going over exercises and discussion
  - 9:45-9:55 Break
  - 9:55-10:20 [Automated testing](https://coderefinery.github.io/testing/continuous-integration/)
      - type-along session
  - 10:20-10:45 [Test design](https://coderefinery.github.io/testing/test-design/)
      - discussion: 5 minutes
      - Exercises: 10 minutes.  Any of exercises Design-1 to Design-8 that learners want to do.
      - discussion and type-along of advanced exercises: 10 minutes
  - 10:45-11:00 Break
```

### 2022 September

Overall, it went well with the schedule below.  We had to be
efficient, but it seemed like it wasn't too hard.  The only complaint
was that there was a lot of time for the first exercise (pytest
locally), which I would agree with.  I think for next time, we should
add in parts of that exercise so that there are more advanced things
to do, since there are more nice features of pytest, such as `--pdb`,
running single tests, etc.  Other than that, there wasn't really much
to report.

The way extra long breaks and a 5-minute starting point were included
is quite good for the schedule.  Not because we needed them, but it
allowed us to go over time and not be under so much time pressure.

```markdown
**Day 6**
* 8:50 - 9:00 Getting started
* 9:00 - 10:45 Software testing
  - 9:00-9:05 Short info about today's exercise sessions and possible questions from yesterday
  - 9:05-9:10 [Motivation](https://coderefinery.github.io/testing/motivation/)
  - 9:10-9:20 [Concepts](https://coderefinery.github.io/testing/concepts/)
  - 9:20-9:45 [Testing locally](https://coderefinery.github.io/testing/pytest/)
      - 5 minutes talking
      - 15 minute exercises
      - 5 going over exercises and discussion
  - 9:45-9:55 Break
  - 9:55-10:20 [Automated testing](https://coderefinery.github.io/testing/continuous-integration/)
      - type-along session
  - 10:20-10:45 [Test design](https://coderefinery.github.io/testing/test-design/)
      - discussion: 5 minutes
      - Exercises: 10 minutes.  Any of exercises Design-1 to Design-8 that learners want to do.
      - discussion and type-along of advanced exercises: 10 minutes
  - 10:45-11:00 Break
```

### 2019 November instructor training workshop

Some notes about teaching are here:
<https://github.com/coderefinery/testing/issues/42>
