# claude-skills-hpc

>#### HPC Reference Skills for Poor People
>a curated, growing pack of [Claude Code](https://claude.com/claude-code) agent skills that teach your AI the HPC standards — parallelism, accelerators, languages — so it answers from the spec, not from vibes.

[![Skills](https://img.shields.io/badge/skills-growing-blue.svg)](#skills)
[![Source](https://img.shields.io/badge/built%20with-book--to--skill-purple.svg)](https://github.com/virgiliojr94/book-to-skill)
[![Install](https://img.shields.io/badge/install-copy%20%7C%20one%20script-green.svg)](#install)
[![License](https://img.shields.io/badge/license-CC--BY--4.0-lightgrey.svg)](#copyrights)

| 📚 **Spec-grounded answers**<br>Each skill distills a full standard — or a practitioner's playbook — into frameworks, decision tables, and worked examples; the agent reads the chapter before answering, instead of hallucinating a flag | 🧭 **Navigable, not a brain-dump**<br>A `SKILL.md` entry point + topic index routes to on-demand `chapters/`; only the relevant chapter is loaded, so context stays cheap | 🔬 **Conformance- and craft-first**<br>For "what does the *standard* actually require?" — constraint IDs, version deltas, send-mode semantics — and for "what's the *right* way to build this?" — decomposition, roofline, the parallel-pitfall catalogue | 🛠️ **Synthesis, not a copy**<br>Original explanatory prose; only API names, code, and numeric spec values coincide with the source — each skill ships a `NOTICE` |
|:---:|:---:|:---:|:---:|
| ⚡ **Drop-in for Claude Code**<br>One `./install.sh` copies them into `~/.claude/skills/`; restart and they trigger automatically on the right questions | 🤝 **Plays nice with dotfiles**<br>Skips any skill you already manage via symlink/stow — won't clobber an existing managed setup | 📦 **Standards + playbooks**<br>The core HPC standards (message passing, offload, languages) plus cross-cutting practitioner playbooks (parallel design, numerics, cluster tooling) — see the full list below, expanding over time | 🆓 **Free & open**<br>CC-BY-4.0 on the original content — share and adapt with attribution |

>#### Built with [book-to-skill](https://github.com/virgiliojr94/book-to-skill)
> These skills are generated, not hand-typed: [book-to-skill](https://github.com/virgiliojr94/book-to-skill) reads a specification or a technical book and extracts its structure — named frameworks, API semantics, anti-patterns, worked examples — into a navigable skill.

---

## Skills

| Skill | Distils | Reach for it when… |
|-------|---------|--------------------|
| `mpi-5.0` | MPI: A Message-Passing Interface Standard, v5.0 | message passing, collectives, RMA, MPI-IO, datatype matching, deadlock hunts |
| `openmp-6.0` | OpenMP API v6.0 (+ Nov-2025 errata) | directives/clauses, tasking, device offload, the flush memory model |
| `openacc-3.4` | OpenACC API v3.4 | `!$acc` directives, data clauses, gang/worker/vector, async queues |
| `fortran-2023-standard` | Fortran 2023 (J3/23-007r1) | what the standard requires/permits; modern-Fortran features; `Cxxx` constraints; conformance |
| `iso-c-9899-2024` | ISO/IEC 9899:2024 — C23 (N3220 draft) | what the standard requires/permits; undefined/unspecified behavior; C23 features; integer promotions; the memory model |
| `iso-cpp-2023` | ISO/IEC 14882 — C++23 (N4950 draft) | well-formed vs UB/IFNDR; value categories & move semantics; concepts/ranges/coroutines; overload resolution; the memory model |
| `cuda-programming` | NVIDIA CUDA Programming Guide, Release 13.3 | CUDA C++/Python kernels, SIMT/tile, streams, graphs, unified memory, multi-GPU |
| `gpu-multithreading` | Cross-technology parallel-programming playbook — design, performance laws, optimization | choosing a decomposition (PCAM); Amdahl/Gustafson/roofline; threads/MPI/CUDA/OpenMP/OpenCL/Thrust; load balancing; diagnosing parallel pitfalls |
| `python-hpc` | Python performance-engineering playbook — CPU and GPU | profiling (cProfile/Scalene/py-spy); NumPy vectorization; compiling (Numba/Cython, the GIL); concurrency (asyncio/multiprocessing/Dask); Polars; Numba-CUDA/CuPy/RAPIDS/JAX |
| `cpp-hpc` | C++ HPC playbook — toolchain, idioms, parallel models, ecosystem | CMake/Spack/SLURM; modern C++ & the STL; parallel-STL/OpenMP/MPI/CUDA; Kokkos portability; HPC hardware & roofline; parallel I/O (HDF5/MPI-IO); debugging/profiling; BLAS/LAPACK/PETSc |
| `hpc-cluster-tooling` | Cluster workflow & command-line tooling playbook | Unix shell for HPC; Make & CMake; git discipline; GDB & sanitizers/Valgrind; profiling (gprof/perf/PAPI/TAU); SLURM batch jobs (sbatch/squeue, arrays, dependencies) |
| `hpc-numerics` | Numerical & algorithmic theory of scientific computing | floating-point/round-off & stability; ODE/PDE discretization & CFL; numerical linear algebra & Krylov/multigrid solvers; roofline & cache blocking; N-body & Monte Carlo |

Each skill lives self-contained under `skills/<name>/`: a `SKILL.md` entry point, on-demand `chapters/`, and supporting `glossary.md` · `patterns.md` · `cheatsheet.md`.

## What they're for

These exist to make the agent a competent pair for *real* HPC work. They were forged alongside [ADAM](https://github.com/szaghi/adam) — a multi-physics AMR SDK for high-performance computing, from laptop to exascale device-accelerated supercomputer — where "is this standard-conforming Fortran, C, or C++?" and "what's the right MPI / OpenACC / CUDA incantation?" are daily questions. Point the agent at a kernel and it can check the actual rule instead of guessing.

## Install

```bash
git clone https://github.com/szaghi/claude-skills-hpc
cd claude-skills-hpc
./install.sh
```

This **copies** each skill into `~/.claude/skills/`. Restart Claude Code (or reload skills) and they trigger automatically. Update later with `git pull && ./install.sh`.

| Command | Does |
|---|---|
| `./install.sh` | install / refresh all skills |
| `./install.sh -n` | dry-run — show what would happen |
| `./install.sh --uninstall` | remove the skills this repo installed |
| `CLAUDE_SKILLS_DIR=/path ./install.sh` | install to a non-default location |

`install.sh` refuses to overwrite a target that is already a **symlink** (e.g. one you manage through your own dotfiles/stow), so it won't trample an existing setup.

---

## Authors

**[Stefano Zaghi](https://github.com/szaghi)** · stefano.zaghi@cnr.it
> *Chief Yak Shaver, Accidental Research Scientist, and HPC Farmer* — decided that re-reading the MPI standard for the hundredth time was one time too many, and taught the robot to do it instead.

**[Claude](https://claude.ai)** (Anthropic)
> *Omniscient Code Oracle & Tireless Rubber Duck* — read the specs so you don't have to, and now quotes constraint IDs back at you.

Contributions welcome — corrections and new skills via pull request. Keep edits to a skill's **own expression** (no verbatim spec prose); new skills must ship a `NOTICE`.

## Copyrights

Original content — the syntheses, structure, explanatory text, tables, and indices — is licensed under **[CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/)** (see [LICENSE](LICENSE)): share and adapt freely, with attribution.

This does **not** relicense third-party material. Each skill carries a `NOTICE` naming its upstream source and terms; API names, code examples, and numeric spec values remain subject to their owners' terms. These skills are independent works — **not** affiliated with, endorsed by, or reproductions of any specification or vendor documentation. For authoritative behavior, consult the upstream source named in each skill's `NOTICE`.

> "CUDA" and "NVIDIA" are trademarks of NVIDIA Corporation; other product and standard names are trademarks of their respective owners.
