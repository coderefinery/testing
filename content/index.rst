Automated testing - Preventing yourself and others from breaking your functioning code
======================================================================================

Have you ever had some of these problems?:

- You change B and C, and suddenly A doesn't work anymore.  Time
  wasted trying to figure out what changed.
- There was some simple problem, systematically testing could have
  found it.
- You get someone else's code and are afraid to touch it because who
  knows what might break.  Plot twist: it's your own code!

People have learned that some automatic way to check problems makes
software development much easier.  This lesson will talk about the
places it's useful for research code, and how easy it can be.
We will discuss why testing often needs to be part of the
software development cycle and how such a cycle can be implemented. We will
see how automated testing works and practice designing and writing tests.

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
   Reusing <https://coderefinery.org/lessons/reusing/>
