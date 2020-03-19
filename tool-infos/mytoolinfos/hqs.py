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

# hqs tool definition by Juraj Síč

import benchexec.result as result
import benchexec.util as util
import benchexec.tools.template

class Tool(benchexec.tools.template.BaseTool):
    """
    Tool info for HQS
    """

    def executable(self):
        return util.find_executable('HQSnp')

    def name(self):
        return 'HQS'


    def determine_result(self, returncode, returnsignal, output, isTimeout):
        if returnsignal == 0:
            if returncode == 10:
                return result.RESULT_SAT
            elif returncode == 20:
                return result.RESULT_UNSAT
            else:
                return "ERROR"
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


    def get_value_from_output(self, lines, identifier):
        # to check if problem was solved by preprocessor - we ignore identifier, there should be only one defined column for benchexec with name like "solved by preprocessor" or something
        for line in lines:
            if line == identifier:
                return True
        return False