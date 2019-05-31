
# 1 查询" 01 "课程比" 02 "课程成绩高的学生的信息及课程分数

SELECT sco.SId, sco.score01, sco.score02,  stu.Sname,  stu.Sage ,stu.Ssex
FROM (SELECT t1.SId, t1.score AS score01, t2.score AS score02
		FROM 
		(
			(SELECT SId, score FROM SC WHERE sc.CId = '01') t1

			INNER JOIN

			(SELECT SId, score FROM SC WHERE sc.CId = '02') t2

			USING(SId)
		)
		WHERE t1.score > t2.score) sco 
	LEFT JOIN Student stu ON sco.SId = stu.SId;

# 1.1 查询同时存在" 01 "课程和" 02 "课程的情况

SELECT s01.SId, s01.Sname,  s01.Sage , s01.Ssex
FROM 
	(
	SELECT sc.SId,stu.Sname,  stu.Sage ,stu.Ssex  
	FROM SC sc, Student stu  
	WHERE sc.SId = stu.SId AND sc.CId = '01') s01

	INNER JOIN

	(
	SELECT sc.SId,stu.Sname,  stu.Sage ,stu.Ssex 
	FROM SC sc, Student stu  
	WHERE sc.SId = stu.SId AND sc.CId = '02') s02

	USING(SId) # On s01.SId = s02.SId

	;

# 2 查询平均成绩大于等于 60 分的同学的学生编号和学生姓名和平均成绩

SELECT DISTINCT SC.SId, AVG(score) AS Average
FROM SC
GROUP BY SId
HAVING AVG(score) >= 60;

# 3 查询在 SC 表存在成绩的学生信息

SELECT id.SId, stu.Sname,  stu.Sage ,stu.Ssex
FROM (SELECT SC.SId
	FROM SC
	GROUP BY SId) id LEFT JOIN Student stu USING(SId);

# 4 查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩(没成绩的显示为 null )

SELECT stat.SId, stu.Sname, stu.Ssex,stat.Work_Load,stat.Total_Score
FROM (
	SELECT SId, COUNT(SId) AS Work_Load,SUM(score) AS Total_Score
	FROM SC
	GROUP BY SId) stat
	
	LEFT JOIN 

	Student stu

	USING(SId);

# 5 查询「李」姓老师的数量

SELECT * 
FROM Teacher 
WHERE Tname LIKE '李%';

# 6 查询学过「张三」老师授课的同学的信息

SELECT stu.SId, zhang.CId, Stu.Sname, Stu.Sage,Stu.Ssex 
FROM
(SELECT sc.SId,d.CId, d.TId,d.Tname
	FROM (SELECT c.CId, c.TId,t.Tname
		FROM Course c, Teacher t
		WHERE c.TId = t.TId) d RIGHT JOIN SC sc on d.CId = sc.CId
	WHERE d.Tname = '张三') zhang

LEFT JOIN Student stu USING(SId);

# 7. 查询没有学全所有课程的同学的信息

# 8. 查询至少有一门课与学号为" 01 "的同学所学相同的同学的信息

# 9. 查询和" 01 "号的同学学习的课程 完全相同的其他同学的信息

# 10. 查询没学过"张三"老师讲授的任一门课程的学生姓名

SELECT DISTINCT Stu.Sname
FROM
(SELECT sc.SId,d.CId, d.TId,d.Tname
	FROM (SELECT c.CId, c.TId,t.Tname
		FROM Course c, Teacher t
		WHERE c.TId = t.TId) d RIGHT JOIN SC sc on d.CId = sc.CId
	WHERE d.Tname != '张三') zhang

LEFT JOIN Student stu USING(SId);


