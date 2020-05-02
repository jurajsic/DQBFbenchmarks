# DQBFbenchmarks
Benchmarks of different DQBF solvers using [BenchExec](https://github.com/sosy-lab/benchexec) framework

## Structure
```
benchmarks/
```
contains all benchmark sets. See the files `explanation.txt` inside this folder and its subfolders for an explanation of benchmarks.

```
results/
```
contains the results of all solvers on all benchmarks.

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
contains the python package defining tool-infos for all solvers.

## Running the Benchmarks
How to run with benchexec:

Install the package `dqbftoolinfos` of tool-info modules:
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