### Create New Variables

* Create variables by group

```sas
data test;
  set test;
	by byvar; 
	if first.byvar then i = -1;
	i + 1;
	grp = int(i/3) + 1;
run; 
```
