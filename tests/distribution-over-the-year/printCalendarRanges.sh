#!/bin/bash

earliestMonthDates=("2024-"{01..12}"-01 12:00")
latestMonthDates=("2023-"{01..12}"-01 12:00")
latestMonthDates=("${latestMonthDates[@]}" "${latestMonthDates[@]}" "${latestMonthDates[@]}" "${latestMonthDates[@]}")
earliestEndDates=("2024-12-31 12:00" "2024-12-31 12:00")
latestEndDates=("2012-12-31 12:00" "2012-12-31 12:00" "2012-12-31 12:00" )

if contains --weekly "$@"; then
    echonl "${earliestMonthDates[@]}" "${earliestEndDates[@]}" | \
	distribution-over-the-year --graph-field 1 --as colorbox-calendar "$@"
    echonl "${latestMonthDates[@]}" "${latestEndDates[@]}" | \
	distribution-over-the-year --graph-field 1 --as colorbox-calendar "$@"
else
    echonl "${earliestMonthDates[@]}" "${earliestEndDates[@]}" "${latestMonthDates[@]}" "${latestEndDates[@]}" | \
	distribution-over-the-year --graph-field 1 --as colorbox-calendar "$@"
fi
