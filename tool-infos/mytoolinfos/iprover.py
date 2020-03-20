# BenchExec is a framework for reliable benchmarking.
# This file is part of BenchExec.
#
# Copyright (C) 2007-2015  Dirk Beyer
# All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# iprover tool definition by Juraj Síč

import benchexec.result as result
import benchexec.util as util
import benchexec.tools.template

class Tool(benchexec.tools.template.BaseTool):
    """
    Tool info for iProver
    """
    
    def executable(self):
        return util.find_executable('iproveropt_v3.1_static')

    def name(self):
        return 'iProver'

    def version(self, executable, arg='--help'):
        return self._version_from_tool(executable, arg='--help').split('- ',1)[1].split(' -',1)[0]
    
    def cmdline(self, executable, options, tasks, propertyfile=None, rlimits={}):
        return [executable] + options + ' --qbf_mode true ' + tasks
    
    def determine_result(self, returncode, returnsignal, output, isTimeout):
        if ((returnsignal == 0) and (returncode == 0)):
            if 'SZS status Satisfiable' in output:
                return result.RESULT_SAT
            elif 'SZS status Unsatisfiable' in output:
                return result.RESULT_UNSAT
            else:
                return result.RESULT_UNKNOWN
        elif ((returnsignal == 9) or (returnsignal == 15)) and isTimeout:
            return "TIMEOUT"
        elif returnsignal == 9:
            return "KILLED BY SIGNAL 9"
        elif returnsignal == 6:
            return "ABORTED"
        elif returnsignal == 15:
            return "KILLED"
        else:
            return "ERROR ({0})".format(returncode)