#!/bin/bash
hammer hostgroup create --name "default" \
	--architecture "x86_64" --domain "home.stc" \
	--environment "home" --content-source-id 1 \
	--puppet-ca-proxy-id 1 --puppet-proxy-id 1 \
	--lifecycle-environment "Library" --subnet "home.stc" \
	--organizations "home" --locations "stc" \
	--query-organization "home" --root-pass 'PassWordRoot'

hammer os set-parameter \
	--name "local_repo" \
	--value "http://192.168.111.14/redhat" \
	--operatingsystem "RedHat 7.6"

hammer hostgroup set-parameter \
	--name "remote_execution_create_user" \
	--value "true" \
	--hostgroup "default"

hammer hostgroup set-parameter \
	--name "remote_execution_effective_user_method" \
	--value "sudo" \
	--hostgroup "default"

hammer hostgroup set-parameter \
	--name "remote_execution_ssh_user" \
	--value "nariga" \
	--hostgroup "default"

hammer hostgroup set-parameter \
	--name "upgrade" \
	--value "false" \
	--hostgroup "default"

hammer hostgroup set-parameter \
	--name "ansible_ssh_key" \
	--value 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYJYa5oHKPblkRlL8Ba6E7TzkT094sRiLQ5tM+2wAailhRWCpmFvZ6g934bI6ojKuBSa8V8YxCY13ePe1W5gXGvwkNoCPB5oOeDzc5IHd2YWIptvw98vILJsSgXz3e/h7UI/vM2KYCUnr8rRcDt2IGio3TlJ8ww930d2i3teTwLi4kuTWpBJTjwFUQQvAbuQo0t50fLO7J8cBa05LzP9o3eOYA65zQ0yn50tAqtQxan3WeFFFGlnnx8bnozD75XYvDB2NKSoF3F95xHYbp48F1ZwuV/rQh6x+IDFqrTVkXmSSrIxe9MP+wWbHwl/vqgGVCvLV8VZQJbbv1cqy4NhEH nariga@ideapad' \
	--hostgroup "default"

hammer hostgroup set-parameter \
	--name "remote_execution_pass_hash" \
	--value 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYJYa5oHKPblkRlL8Ba6E7TzkT094sRiLQ5tM+2wAailhRWCpmFvZ6g934bI6ojKuBSa8V8YxCY13ePe1W5gXGvwkNoCPB5oOeDzc5IHd2YWIptvw98vILJsSgXz3e/h7UI/vM2KYCUnr8rRcDt2IGio3TlJ8ww930d2i3teTwLi4kuTWpBJTjwFUQQvAbuQo0t50fLO7J8cBa05LzP9o3eOYA65zQ0yn50tAqtQxan3WeFFFGlnnx8bnozD75XYvDB2NKSoF3F95xHYbp48F1ZwuV/rQh6x+IDFqrTVkXmSSrIxe9MP+wWbHwl/vqgGVCvLV8VZQJbbv1cqy4NhEH nariga@ideapad' \
	--hostgroup "default"

hammer hostgroup set-parameter \
	--name "remote_execution_ssh_keys" \
	--value 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYJYa5oHKPblkRlL8Ba6E7TzkT094sRiLQ5tM+2wAailhRWCpmFvZ6g934bI6ojKuBSa8V8YxCY13ePe1W5gXGvwkNoCPB5oOeDzc5IHd2YWIptvw98vILJsSgXz3e/h7UI/vM2KYCUnr8rRcDt2IGio3TlJ8ww930d2i3teTwLi4kuTWpBJTjwFUQQvAbuQo0t50fLO7J8cBa05LzP9o3eOYA65zQ0yn50tAqtQxan3WeFFFGlnnx8bnozD75XYvDB2NKSoF3F95xHYbp48F1ZwuV/rQh6x+IDFqrTVkXmSSrIxe9MP+wWbHwl/vqgGVCvLV8VZQJbbv1cqy4NhEH nariga@ideapad' \
	--hostgroup "default"
