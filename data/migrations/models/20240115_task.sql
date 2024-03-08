CREATE TABLE Task (
  id INTEGER NOT NULL PRIMARY KEY,
  -- function name
  fn TEXT NOT NULL,
  argsJSON TEXT,
  -- sort DESC (higher priority runs first)
  priority INTEGER DEFAULT 0,
  -- number of remaining retries for this job instance (we run tasks with more retries first so we attempt every task once before working on tasks that need to be retried)
  retries INTEGER DEFAULT 0
) STRICT;

-- don't schedule the same work twice. This is also used for a SELECT fn, count(*) query.
CREATE UNIQUE INDEX task_fn_args_udx ON Task (fn, argsJSON);

-- index to determine the next task(s) to run:
CREATE INDEX task_pri_retries_id_idx ON Task (priority, retries, id);
