# DQBFbenchmarks
Benchmarks of different DQBF solvers using BenchExec framework


How to run with benchexec:

Add directory with solvers to PATH variable (assuming you are in the DQBFbenchmarks directory):
```
PATH=$PATH:$(pwd)/solvers
```
Then either move tool-info files to tools directory in benchexec and change some stuff with benchmark-definition files (TODO explain both better) or install the package in tool-infos directory (here we install in virtual enviroment using venv and install it only for current user):
```
mkdir benchexecvirtual/
python3 -m venv benchexecvirtual/
source benchexecvirtual/bin/activate
pip3 install --user tool-infos
```
If you used this way, you will be in a virtual enviroment in which the package with tool-infos is installed (you can leave it by using command 'deactivate'). This way the package is not installed globally and whenever you want to run any benchmarks you can just use
```
source benchexecvirtual/bin/activate
```
to again activate this virtual enviroment. To now run benchexec do
```
benchexec benchmark-definitions/benchmark-NAMEOFTOOL.xml
```
where you replace NAMEOFTOOL with solver you want to run.