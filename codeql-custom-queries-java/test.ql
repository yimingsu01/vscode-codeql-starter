/**
 * @name Null check
 * @description Null check script
 * @kind problem
 * @problem.severity warning
 * @id java/value-check
 * @tags reliability
 */


import java
import semmle.code.java.dataflow.SSA
import semmle.code.java.dataflow.NullGuards

from MethodAccess ma, SsaVariable sv
where
    // Look for calls to method with following name
    ma.getCallee().getName() = "smooth" and 
    // Check if argument number (0,1,2..) can be null
    ma.getArgument(0).(VarAccess) = sv.getAUse() and not clearlyNotNull(sv)
    // ma.getArgument(0).(VarAccess).getVariable().getAnAssignedValue() < 

select ma, "Variable " + sv.getSourceVariable().getVariable().getName() + " may be null here"
// select ma
// select ma.getArgument(0).(VarAccess).getVariable().getAnAssignedValue()