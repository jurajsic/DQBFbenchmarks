# DQBFbenchmarks
Benchmarks of different DQBF solvers using [BenchExec](https://github.com/sosy-lab/benchexec) framework used for my [master's thesis](https://is.muni.cz/th/prexv/) and [DQBDD tool paper](https://doi.org/10.1007/978-3-030-80223-3_36). See the [tagged](https://github.com/jurajsic/DQBFbenchmarks/tags) versions for the exact commit used for these.

## Structure
```
benchmarks/
```
contains all benchmark sets. See the files `explanation.txt` inside this folder and its subfolders for an explanation of benchmarks.

```
results/
```
contains the raw results of all solvers on all benchmarks where

```
results/combinedresults
```
contains Microsoft Excel files with nicely summarised comparison of solvers for each benchmark (as used in my [master's thesis](https://is.muni.cz/th/prexv/) and DQBDD tool paper).

```
solvers/
```
contains executables of DQBF solvers.

```
benchmark-definitions/
```
contains Benchexec run definition files for all solvers.

```
tool-infos/
```
contains the python package defining [tool-infos](https://github.com/sosy-lab/benchexec/blob/master/doc/tool-integration.md) for all solvers.

## Running the Benchmarks
How to run with benchexec:

Install the package `dqbftoolinfos` of [tool-info](https://github.com/sosy-lab/benchexec/blob/master/doc/tool-integration.md) modules:
```
pip3 install tool-infos/
```

Add the directory with solvers to PATH variable (assuming you are in the `DQBFbenchmarks/` directory):
```
PATH=$PATH:$(pwd)/solvers
```

To now run benchexec with a chosen tool do
```
benchexec benchmark-definitions/benchmark-NAMEOFTOOL.xml
```
where you replace NAMEOFTOOL with solver you want to run. You can also use `-t TASKNAME` to run only some benchmarks and `-r RUNDEFINITION` to run only some definition for a given tool. See BenchExec [documentation](https://github.com/sosy-lab/benchexec/blob/master/doc/INDEX.md) and the definition files in `benchmark-definitions/` for more info.
