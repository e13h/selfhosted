#!/bin/bash

(
	docker exec \
		-e PGPASSWORD=your_secret_password \
		onelineaday-db-1 \
		psql \
			-U journal \
			-d journal_db \
			-t \
			-A \
			-c "SELECT json_agg(row_to_json(t)) FROM (SELECT date, message FROM journal_entries) t;" \
	| jq
) > onelineaday_export_$(date -Is).json
