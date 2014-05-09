# encoding: utf-8
#
# Cookbook Name:: octohost
# Recipe:: rackspace
#
# Copyright (C) 2014, Darron Froese <darron@froese.org>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

bash 'Update PRIVATE_IP for rackspace.' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    sed -i '6s/.*/PRIVATE_IP=\$\(ifconfig eth1 \| grep \"inet addr\" \| cut -d \':\' -f 2\)/' /etc/default/octohost
  EOH
end
