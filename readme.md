![](https://assets-global.website-files.com/5b69e8315733f2850ec22669/5b749a4663ff82be270ff1f5_GSC%20Lockup%20(Orange%20%3A%20Black).svg)

### Welcome to the take home portion of your interview! We're excited to jam through some technical stuff with you, but first it'll help to get a sense of how you work through data and coding problems. Work through what you can independently, but do feel free to reach out if you have blocking questions or problems.

1) This requires Postgres (9.4+) & Rails(4.2+), so if you don't already have both installed, please install them.

2) Download the data file from: https://github.com/gospotcheck/ps-code-challenge/blob/master/Street%20Cafes%202015-16.csv

_To complete this, I created a RakeTask that took all data present in the CSV and created a StreetCafe model that was inserted into the database, this is done by running `rake import` off the CLI. Today I Learned: Rails pluralizes cafe => caves, so I had to also redefine the correct inflection in config/initializers/inflections.rb_

3) Add a varchar column to the table called `category`. 

_I ran this off the CLI using `rails g migration add_category_to_street_cafe category:varchar`_

4) Create a view with the following columns[provide the view SQL]
    - post_code: The Post Code
    - total_places: The number of places in that Post Code
    - total_chairs: The total number of chairs in that Post Code
    - chairs_pct: Out of all the chairs at all the Post Codes, what percentage does this Post Code represent (should sum to 100% in the whole view)
    - place_with_max_chairs: The name of the place with the most chairs in that Post Code
    -max_chairs: The number of chairs at the place_with_max_chairs

_Query used:_
```
CREATE VIEW post_code_cafe_data AS
SELECT post_code, 
	COUNT(post_code) AS total_places, 
	SUM(chairs) AS total_chairs, 
	ROUND(SUM(chairs) * 100 / SUM(SUM(chairs)) OVER(), 2) AS chairs_pct, 
	(SELECT S2.name FROM street_cafes S2 WHERE S1.post_code = S2.post_code ORDER BY S2.chairs DESC LIMIT(1)) AS place_with_max_chairs, 
	MAX(chairs) AS max_chairs 
	FROM street_cafes S1 
	GROUP BY post_code;
```
 
   *Please also include a brief description of how you verified #4*
   
_I decided to create a test_data.csv with 10 rows of dummy data. This is imported to the `ps-code-challenge_test` database using a similar raketask by running `RAILS_ENV=test rake import_test_data` on the CLI. I am then able to manually check my calculations with a really small set of data which I have included below:_ 

![test_data_sql](https://i.ibb.co/m9bVptt/Screen-Shot-2020-02-06-at-1-18-42-PM.png)

5) Write a Rails script to categorize the cafes and write the result to the category according to the rules:[provide the script]
    - If the Post Code is of the LS1 prefix type:
        - `# of chairs less than 10: category = 'ls1 small'`
        - `# of chairs greater than or equal to 10, less than 100: category = 'ls1 medium'`
        - `# of chairs greater than or equal to 100: category = 'ls1 large' `
    - If the Post Code is of the LS2 prefix type: 
        - `# of chairs below the 50th percentile for ls2: category = 'ls2 small'`
        - `# of chairs above the 50th percentile for ls2: category = 'ls2 large'`
    - For Post Code is something else:
        - `category = 'other'`

    *Please share any tests you wrote for #5*
    
    _This command is run off the cli using the command `rake assign_categories`. My test file is included in `spec/tasks/assign_categories_spec.rb` I used RSpec to test this rake task._

6) Write a custom view to aggregate the categories [provide view SQL AND the results of this view]
    - category: The category column
    - total_places: The number of places in that category
    - total_chairs: The total chairs in that category
    
    SQL Query:
```
    CREATE VIEW category_cafe_data AS
		SELECT category, 
		COUNT(category) AS total_places, 
		SUM(chairs) AS total_chairs 
		FROM street_cafes 
		GROUP BY category;
```
![category_data](https://i.ibb.co/WvyxRLc/Screen-Shot-2020-02-06-at-4-16-21-PM.png)

7) Write a script in rails to:
    - For street_cafes categorized as small, write a script that exports their data to a csv and deletes the records
    - For street cafes categorized as medium or large, write a script that concatenates the category name to the beginning of the name and writes it back to the name column
	
    *Please share any tests you wrote for #7*
    
    _This command is run off the CLI using `rake reassign_cafes`. My spec file is in `spec/tasks/create_small_cafe_csv_spec.rb`. I used RSpec to test this functionality._

8) Show your work and check your email for submission instructions.

9) Celebrate, you did great! 


