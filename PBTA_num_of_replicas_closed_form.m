function [num_of_replicas, actual_allocated_total_replicas] = PBTA_num_of_replicas_closed_form(n, m, tasks_priorities)
% This function returns the number of replicas allocated for each task 
% based on their priorities. 
% This function returns the number of replicas 'num_of_replicas' based on
% the tasks' priorities 'tasks_priorities' for 'm' number of tasks.
% The function will use a closed form (symbolic) equation to split the 'm'
% tasks on the 'n' workers based on the tasks' priorities
% 'tasks_priorities'.

%% First, we calculate the value of the Lagrangian multiplier \lambda^{(1)}
lambda_1 = (1 .* (n ./ m)) .* (1 - ((1 ./ m) .* sum(tasks_priorities)));
get_num_of_replicas_per_task = @(n, m, task_priority, lambda_1) ((n ./ m) .* task_priority) + ( (lambda_1) ./ 2);

num_of_replicas = zeros(1, m);
for j = 1: m
    r = floor(get_num_of_replicas_per_task(n, m, tasks_priorities(j), lambda_1));
    num_of_replicas(1, j) = r;
end

actual_allocated_total_replicas = sum(num_of_replicas);
end

