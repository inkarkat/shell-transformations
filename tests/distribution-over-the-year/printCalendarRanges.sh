#!/bin/bash

earliestMonthDates=("2023-"{01..12}"-01 12:00")
earliestMonthDates=("${earliestMonthDates[@]}" "${earliestMonthDates[@]}" "${earliestMonthDates[@]}" "${earliestMonthDates[@]}")
latestMonthDates=("2024-"{01..12}"-01 12:00")
earliestEndDates=("2024-12-31 12:00" "2024-12-31 12:00")
latestEndDates=("2012-12-31 12:00" "2012-12-31 12:00" "2012-12-31 12:00" )

echonl "${earliestMonthDates[@]}" "${earliestEndDates[@]}" "${latestMonthDates[@]}" "${latestEndDates[@]}" | \
    distribution-over-the-year --graph-field 1 --as colorbox-calendar "$@"
