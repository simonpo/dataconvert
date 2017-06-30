# dataconvert

A perl script that reads a tab delimited .csv, pulls out  data, stuffs all the concert town/venue/year events into a hash indexed on month-day, and writes a file containing a list of concerts by the band that happened on that month-day across all the years they played. 

Why perl? Because I hadn't used it in forever, I used to love it, and I wanted to see if I could. 

Why make these files? I might do something interesting with them, and it seems cheaper to create a file for each day and import that rather than use a db that's not going to change often. If I update the original .csv, I can just regenerate all the txt files. 