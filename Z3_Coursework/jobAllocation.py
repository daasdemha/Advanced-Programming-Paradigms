from z3 import *
import time

def valuesAddedToVariables(jobsPerWorker):

  """  

   Jobs 1,2,3,4,5,6,7,8,9,11,12,13 are dealt with here.
   The Function valuesAddedToVariables takes 1 parameter which is jobsPerWorker 
   12 jobs 1,2,3,4,5,6,7,8,9,11,12,13 and all three workers.

   Following actions take place in this function:

   If worker one is doing the job then the Jobs are multiplied with *2 eg(j1*2, j2*2 ...)
   If worker two is doing the job then the Jobs are added 5 eg(j1+5, j2+5 ...)
   If worker three is doing the job then the Jobs are added 20  eg(j1+20, j2+20 ...)

   One worker is selected to perform the job.

   The other workers take 0 time in that specific job. eg (j1w1==1*2, j1w2==0, j1w3==0 ...)

   It is specified that each job is between 0 and 35 and jobs cannot be 1, 3 and 5.

   it retuns all of the above mentioned as a Z3 Conditional Statement.

  """

  new_list = [1,2,3,4,5,6,7,8,9,11,12,13]
  return [

        And(Or(
        Or(jobsPerWorker[0][i] == new_list[i]*2      ,    jobsPerWorker[0][i] == 0),
        Or(jobsPerWorker[1][i] == new_list[i]+5      ,    jobsPerWorker[1][i] == 0),
        Or(jobsPerWorker[2][i] == new_list[i]+20     ,    jobsPerWorker[2][i] == 0)),
        
        jobsPerWorker[0][i] >= 0, jobsPerWorker[1][i] >= 0, jobsPerWorker[2][i] >= 0,
        jobsPerWorker[0][i] != 1, jobsPerWorker[1][i] != 1, jobsPerWorker[2][i] != 1,
        jobsPerWorker[0][i] != 3, jobsPerWorker[1][i] != 3, jobsPerWorker[2][i] != 3,
        jobsPerWorker[0][i] != 5, jobsPerWorker[1][i] != 5, jobsPerWorker[2][i] != 5,

        jobsPerWorker[0][i] <= 35, jobsPerWorker[1][i] <= 35, jobsPerWorker[2][i] <= 35,
        )
        for i in range(12)

  ]

def removeSpecialJobs(jobsPerWorker):

  """  

   Jobs 1,2,3,4,5,6,7,8,9,11,12,13 are dealt with here.
   The Function removeSpecialJobs takes 1 parameter which is total number of jobs and workers.
   it returns jobs and workes with Jobs j10, j14, and j15 removed from the list.

   it returns jobs 1,2,3,4,5,6,7,8,9,11,12,13 with worker 1 , 2 and 3

  """
  
  return [[jobsPerWorker[j][i] for i in [0,1,2,3,4,5,6,7,8,10,11,12]] for j in [0,1,2]]


def ValidityCheck(jobsPerWorkerwithremovedelements):

  """  

   Jobs 1,2,3,4,5,6,7,8,9,11,12,13 are dealt with here.
   The Function ValidityCheck takes 1 parameter which is jobsPerWorkerwithremovedelements 
   12 jobs 1,2,3,4,5,6,7,8,9,11,12,13 and all three workers.

   It returns a Z3 Conditional Statement that only one worker can do one job.

"""
  
  return [

    If(jobsPerWorkerwithremovedelements[0][i] > 0,True,
    If(jobsPerWorkerwithremovedelements[1][i] > 0,True, 
    If(jobsPerWorkerwithremovedelements[2][i] > 0,True,
    False)))
  
    for i in range(12)
  
  ]

def Job101415(jobsPerWorker):

  """  

   Jobs 10 , 14 and 15 are dealt with here.
   The Function valuesAddedToVariables takes 1 parameter which is jobsPerWorker 
   12 jobs 10, 14, 15 and all three workers.

   Following actions take place in this function:

   If worker one is doing the job then the Jobs are multiplied with *2 eg(j10*2, j14*2 ...)
   If worker two is doing the job then the Jobs are added 5 eg(j10+5, j14+5 ...)
   If worker three is doing the job then the Jobs are added 20  eg(j10+20, j14+20 ...)

   One worker is selected to perform the job.

   The other workers take 0 time in that specific job. eg (j10w1==10*2, j10w2==0, j10w3==0 ...)

   It is specified that each job is between 0 and 35 and jobs cannot be 1, 3 and 5.

   It returns all of the above mentioned as a Z3 Conditional Statement.

  """

  return [
    
    And(
    Or(And(jobsPerWorker[0][9] == 10 *2  ,jobsPerWorker[0][13]== 14 *2    , jobsPerWorker[0][14]== 15 *2), 
       And(jobsPerWorker[0][9] == 0      ,jobsPerWorker[0][13]== 0        , jobsPerWorker[0][14]== 0 )),

    Or(And(jobsPerWorker[1][9] == 10 +5  ,jobsPerWorker[1][13]== 14 +5   , jobsPerWorker[1][14]== 15 +5), 
       And(jobsPerWorker[1][9] == 0      ,jobsPerWorker[1][13]== 0       , jobsPerWorker[1][14]== 0)),

    Or(And(jobsPerWorker[2][9] == 10 +20 ,jobsPerWorker[2][13]== 14 +20  , jobsPerWorker[2][14]== 15 +20), 
       And(jobsPerWorker[2][9] == 0      ,jobsPerWorker[2][13]== 0       , jobsPerWorker[2][14]== 0)),

       jobsPerWorker[0][9] >= 0, jobsPerWorker[0][13] >= 0, jobsPerWorker[0][14] >= 0,
       jobsPerWorker[1][9] >= 0, jobsPerWorker[1][13] >= 0, jobsPerWorker[1][14] >= 0,
       jobsPerWorker[2][9] >= 0, jobsPerWorker[2][13] >= 0, jobsPerWorker[2][14] >= 0,

       jobsPerWorker[0][9] != 1, jobsPerWorker[0][13] != 1, jobsPerWorker[0][14] != 1,
       jobsPerWorker[1][9] != 3, jobsPerWorker[1][13] != 3, jobsPerWorker[1][14] != 3,
       jobsPerWorker[2][9] != 5, jobsPerWorker[2][13] != 5, jobsPerWorker[2][14] != 5,

       jobsPerWorker[0][9] <= 35, jobsPerWorker[0][13] <= 35, jobsPerWorker[0][14] <= 35,
       jobsPerWorker[1][9] <= 35, jobsPerWorker[1][13] <= 35, jobsPerWorker[1][14] <= 35,
       jobsPerWorker[2][9] <= 35, jobsPerWorker[2][13] <= 35, jobsPerWorker[2][14] <= 35
       )
    ]

def ValidityCheck2(jobsPerWorker): 

  """

   The function Job101415 takes one input jobsPerWorker
   the case that Jobs j10, j14, and j15 must all be undertaken by the same worker is dealt with here.
   Only job10 has been validated with each worker as other jobs 10 14 and 15 are connected with each worker using an And
   the mentioned connection can be observed in the function Job101415

   It returns all of the above mentioned as a Z3 Conditional Statement.

  """
  return [
    Or(

    If(jobsPerWorker[0][9] > 0,True,
    If(jobsPerWorker[1][9] > 0,True, 
    If(jobsPerWorker[2][9] > 0,True,
    False))),

    If(jobsPerWorker[0][13] > 0,True,
    If(jobsPerWorker[1][13] > 0,True, 
    If(jobsPerWorker[2][13] > 0,True,
    False))),

    If(jobsPerWorker[0][14] > 0,True,
    If(jobsPerWorker[1][14] > 0,True, 
    If(jobsPerWorker[2][14] > 0,True,
    False)))
    
    )
    ]



def specifyingWhatEachWorkerAndJobIsNot(jobsPerWorker,cost,index):

  """
  
  The function specifyingWhatEachWorkerAndJobIsNot has three parameters jobsPerWorker,cost and index.
  It states that each worker cannot have specific cost. 
  eg: worker1j1 cannot have cost other then 2. eg: worker1j1 != [4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30]
  It returns the result from this evaluation as a Z3 Conditional Statement.
  
  """

  return [(jobsPerWorker[index][i] != j) for i in range(15) for j in cost[:i] + cost[i+1:] ] 

def specifyingWhatEachWorkerAndJobIsNotPart2(jobsPerWorker,cost,index):

  """
  
  The function specifyingWhatEachWorkerAndJobIsNotPart2 has three parameters jobsPerWorker,cost and index.
  It states that each worker cannot have specific cost. 
  eg: worker1j1 cannot have cost other then 2. eg: worker1j1 != [7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 32, 33, 34, 35]
  It returns the result from this evaluation as a Z3 Conditional Statement.
  
  """

  return [(jobsPerWorker[index][j] != i) for j in range(15) for i in cost]

def specifyingWhatEachWorkerAndJobIsNotPart3(jobsPerWorker):

  """
  
  The function specifyingWhatEachWorkerAndJobIsNotPart3 has one parameter jobsPerWorker.
  It states that each worker cannot have specific cost. 
  eg: worker1j1 cannot have cost other then 2. eg: worker1j1 != [4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30] + [7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 32, 33, 34, 35]
  It uses the functions specifyingWhatEachWorkerAndJobIsNot specifyingWhatEachWorkerAndJobIsNotPart2 to achive this.
  It returns the result from this evaluation as a Z3 Conditional Statement..
  
  """

  a = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30]
  b = [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
  c = [21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35]

  return  (specifyingWhatEachWorkerAndJobIsNot(jobsPerWorker,a,0) + 
  specifyingWhatEachWorkerAndJobIsNot(jobsPerWorker,b,1) + 
  specifyingWhatEachWorkerAndJobIsNot(jobsPerWorker,c,2) +
  specifyingWhatEachWorkerAndJobIsNotPart2(jobsPerWorker,[item for item in b+c if item not in a],0) +
  specifyingWhatEachWorkerAndJobIsNotPart2(jobsPerWorker,[item for item in a+c if item not in b],1) +
  specifyingWhatEachWorkerAndJobIsNotPart2(jobsPerWorker,[item for item in a+b if item not in c],2))
  

def sumOfWorkers(jobsPerWorker,Workers,index):

  """

  The function sumOfWorkers has three parameters jobsPerWorker,Workers,index
  It Sums the cost of given worker and returns it a Z3 Varibale that can be used as a Z3 Conditional Statement.
  
  """
  return [Workers[index] == Sum([jobsPerWorker[index][j] for j in range(15)])]


def printResults(efficient_Working_conds,extraxonstraint,jobsPerWorker,Workers,hastags):
    """
    
    The function printResults has 4 parameters efficient_Working_conds,extraxonstraint,
    jobsPerWorker,Workers and hastags.
    
    It uses constrains/conditions/clauses efficient_Working_conds and extraxonstraint to get a solution
    from z3.
    
    It uses jobsPerWorker and Workers to print the solution.

    hastags are just a print statememnt.

    The function returns nothing.
    
    """
    s = Solver() 
    s.push()  
    s.add(efficient_Working_conds + [Workers[0]<extraxonstraint] + 
     [Workers[1]<extraxonstraint] + [Workers[2]<extraxonstraint]) 
    foundSol = s.check()
    if foundSol==sat:  
      
      m = s.model()

      print("\nThe Jobs are perfromed by the Follwing workers for the best solution: ") 
      print("WorkerA: ", ["wAj%s" % (i+1) for i in range(15) 
          if m.evaluate(jobsPerWorker[0][i]).as_long() > 0])
      print("Cost:    ",["wAj%s==%s" % ((i+1), m.evaluate(jobsPerWorker[0][i])) for i in range(15) 
          if m.evaluate(jobsPerWorker[0][i]).as_long() > 0])
      print("WorkerB: ", ["wBj%s" % (i+1) for i in range(15) 
          if m.evaluate(jobsPerWorker[1][i]).as_long() > 0])
      print("Cost:    ",["wBj%s==%s" % ((i+1), m.evaluate(jobsPerWorker[1][i])) for i in range(15) 
          if m.evaluate(jobsPerWorker[1][i]).as_long() > 0])
      print("WorkerC: ", ["wCj%s" % (i+1) for i in range(15) 
          if m.evaluate(jobsPerWorker[2][i]).as_long() > 0])
      print("Cost:    ",["wCj%s==%s" % ((i+1), m.evaluate(jobsPerWorker[2][i])) for i in range(15) 
          if m.evaluate(jobsPerWorker[2][i]).as_long() > 0])
      
      print("\nThe total cost of workers required in the best solution are: ")
      print(["w%s==%s" % ("ABC"[i], m.evaluate(Workers[i])) for i in range(3)])
      
      print("\nThe highest cost from this solution is: ")
      print(["w%s==%s" % ("ABC"[i], m.evaluate(Workers[i])) for i in range(3) 
      if m.evaluate(Workers[i]).as_long() >= max([m.evaluate(Workers[0]).as_long(),
                                                  m.evaluate(Workers[1]).as_long(),
                                                  m.evaluate(Workers[2]).as_long()])])
      print(hastags)


def main():

  # Section 1
  jobsPerWorker = [ [ Int("w%sj%s" % (j, i+1)) for i in range(15) ] for j in "ABC"]  # jobs per worker eg [[w1j1..],[w2j1..],[w3j1..]]
  jobsPerWorkerwithremovedelements = removeSpecialJobs(jobsPerWorker)  # Jobs 1,2,3,4,5,6,7,8,9,11,12,13 for each worker. eg [[w1j1..],[w2j1..],[w3j1..]]
  c1                               = valuesAddedToVariables(jobsPerWorkerwithremovedelements)  # Read function doc strings for details.
  c2                               = ValidityCheck(jobsPerWorkerwithremovedelements)  # Read function doc strings for details.
  c3                               = Job101415(jobsPerWorker)  # Read function doc strings for details.
  c4                               = ValidityCheck2(jobsPerWorker)  # Read function doc strings for details.
  c5                               = specifyingWhatEachWorkerAndJobIsNotPart3(jobsPerWorker)  # Read function doc strings for details.
  
  # Section 2
  Workers = [ Int("w%s" % i) for i in "ABC" ]  # Workers A B and C are assigned here to find there cost. eg [w1,w2,w3]
  c6                               = sumOfWorkers(jobsPerWorker,Workers,0)  # Read function doc strings for details.
  c7                               = sumOfWorkers(jobsPerWorker,Workers,1)  # Read function doc strings for details.
  c8                               = sumOfWorkers(jobsPerWorker,Workers,2)  # Read function doc strings for details.

  
  
  # Section 3
  efficient_Working_conds = c1+c2+c3+c4+c5+c6+c7+c8  # All of the clauses are added.

  s = Solver()  # solver is created.
  s.push()  # solver is pushed to.
  s.add(efficient_Working_conds)  # All the clauses are added to the solver.
  hastags = ("###############################################################################################################################")  # assighns value to variable.
  print(hastags)  # prints the hastags varibles value.
  print("Finding Solution...")  # The statememnt is printed.

  t1=time.perf_counter() # timing counter is set.
  i = 195  # the value of i is set.
  while i != 0:  # base case.
    foundSol = s.check()  # checking if solution is found.
    if foundSol==sat:  # if solution is found.
        s.push()  # push to s.
        s.add([Workers[0]<i]+[Workers[1]<i]+[Workers[2]<i])  # add this clause to s.
        i = i - 1  # i is re assighned.
    else:  # base case 2. to break out of the loop earlier. if no solution is found.
        i = i + 2  # i is re assighned.
        break  # the loop is broken.
  t2=time.perf_counter()  # the time is counted.
  print("Solution found.")
  print("Solver finished in: " + str(t2-t1))  # The time taken is printed.
  printResults(efficient_Working_conds,i,jobsPerWorker, Workers, hastags)  # check function for more details.

main()