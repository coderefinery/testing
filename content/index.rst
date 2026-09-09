Automated testing - Preventing yourself and others from breaking your functioning code
======================================================================================

In this lesson we discuss the basics of *automated* testing.

We start discussing why automated testing is important.
We then show how to set up automated testing in your projects
in a few programming languages,
so that you can run a test suite conveniently on your own computer.
We will then show how to make GitHub (or GitLab)
run the test suite automatically
(typically whenever someone pushes to the repository),
and tell us when there was a problem.

If time allows,
we might do that in a collaborative fashion,
running the test suite on a pull request
to inform the code review process.

Writing tests can be challenging sometimes,
so we will discuss typical problems in test design,
mentioning also *Test Driven Develpment*,
and practice designing and writing tests.

The goals of the module
is to make the learners feel comfortable
with setting up a test suite of automated tests,
feel familiar with the automation options
on Software forges (e.g. GitHub and GitLab),
and make them aware of the typical challenges
in writing automated tests.

.. prereq::

   1. You need `pytest <http://doc.pytest.org>`__ (as part of Anaconda or Miniconda or Virtual Environment).

   2. (Optional) To work on exercises in other languages than Python,
      please follow the instructions under "Language-specific
      instructions" in the `Test design episode <https://coderefinery.github.io/testing/test-design/>`__
      to install the recommended testing frameworks.

   3. Basic understanding of Git.

   4. You need a `GitHub <https://github.com>`__ or a `Gitlab
      <https://gitlab.com/>`__ account for the "automated testing" and
      "full-cycle collaborative workflow" (but the rest works fine
      just locally).

   5. If you wish to follow in the terminal and are new to the command line, we
      recorded a `short shell crash course <https://youtu.be/xbTTDLA3txI>`__.


.. csv-table::
   :widths: auto
   :delim: ;

   15 min ; :doc:`motivation`
   25 min ; :doc:`locally`
   30 min ; :doc:`continuous-integration`
   30 min ; :doc:`test-design`
   5 min ; :doc:`conclusions`


.. toctree::
   :maxdepth: 1
   :caption: The lesson

   motivation
   locally
   continuous-integration
   test-design
   conclusions
   full-cycle-ci


.. toctree::
   :maxdepth: 1
   :caption: Reference

   Shell crash course <https://youtu.be/xbTTDLA3txI>
   exercises
   quick-reference
   guide


.. toctree::
   :maxdepth: 1
   :caption: About

   All lessons <https://coderefinery.org/lessons/core/>
   CodeRefinery <https://coderefinery.org/>
   reusing
