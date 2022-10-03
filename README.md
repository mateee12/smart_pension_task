# install dependencies
- install ruby specified in Gemfile
- make sure correct ruby version is active `ruby -v`
- install gems `bundle install`
- make sure `./parser.rb` file is executable, e.g.: `chmod +x ./parser.rb`
- run tests to check local env setup is correct `bundle exec rspec`

# example of usages
It is possible to customize multiple options in this script.
All these options can be independently combined
- You can customize source type and path (.log, others_to_come)
- report type (service responsible for report data preparation)
- output view (different output views, also generic views for STDOUT, others_to_come)

### see list of accesible commands
command `./parser.rb`

### details of specific generate_report action
command `./parser.rb help generate_report`


output
```
Usage:
  parser.rb generate_report --report=REPORT --source-path=SOURCE_PATH --source-type=SOURCE_TYPE

Options:
  --source-path=SOURCE_PATH                  
  --source-type=SOURCE_TYPE                  
                                             # Possible values: log, csv
  --report=REPORT                            
                                             # Possible values: PagesOrderedByVisits, PagesOrderedByUniqueVisits
  [--output-view=OUTPUT_VIEW]                
                                             # Possible values: StdoutVisitsCount, StdoutUniqueVisitsCount, StdoutGeneric
  [--output-destination=OUTPUT_DESTINATION]  
                                             # Default: stdout

generate report of certain type from data source file                                                                                               # Describe available commands or one specific command
```

### Exact Task commands!!!
- `./parser.rb generate_report --source-path spec/log_data/webserver.log --source-type log --report PagesOrderedByVisits`
- `./parser.rb generate_report --source-path spec/log_data/webserver.log --source-type log --report PagesOrderedByUniqueVisits`

### Other examples
- print to generic stdout `./parser.rb generate_report --source-path spec/log_data/webserver.log --source-type log --report PagesOrderedByVisits --output-view StdoutGeneric`

# Application Architecture
parser.lib and content in /lib folder is following **layered architectural pattern**.
![Alt text](smart_pension_task_layered_architecture.drawio.png?raw=true "Application Layered pattern")
