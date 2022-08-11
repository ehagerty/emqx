%%--------------------------------------------------------------------
%% Copyright (c) 2022 EMQ Technologies Co., Ltd. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%--------------------------------------------------------------------

-module(emqx_resource_schema).

-include("emqx_resource.hrl").
-include_lib("hocon/include/hoconsc.hrl").

-import(hoconsc, [mk/2, enum/1, ref/2]).

-export([namespace/0, roots/0, fields/1]).

%% -------------------------------------------------------------------------------------------------
%% Hocon Schema Definitions

namespace() -> "resource_schema".

roots() -> [].

fields('batch&async&queue') ->
    [
        {query_mode, fun query_mode/1},
        {resume_interval, fun resume_interval/1},
        {async_inflight_window, fun async_inflight_window/1},
        {batch, mk(ref(?MODULE, batch), #{desc => ?DESC("batch")})},
        {queue, mk(ref(?MODULE, queue), #{desc => ?DESC("queue")})}
    ];
fields(batch) ->
    [
        {enable_batch, fun enable_batch/1},
        {batch_size, fun batch_size/1},
        {batch_time, fun batch_time/1}
    ];
fields(queue) ->
    [
        {enable_queue, fun enable_queue/1},
        {max_queue_bytes, fun queue_max_bytes/1}
    ].

query_mode(type) -> enum([sync, async]);
query_mode(desc) -> ?DESC("query_mode");
query_mode(default) -> sync;
query_mode(required) -> false;
query_mode(_) -> undefined.

enable_batch(type) -> boolean();
enable_batch(required) -> false;
enable_batch(default) -> false;
enable_batch(desc) -> ?DESC("enable_batch");
enable_batch(_) -> undefined.

enable_queue(type) -> boolean();
enable_queue(required) -> false;
enable_queue(default) -> false;
enable_queue(desc) -> ?DESC("enable_queue");
enable_queue(_) -> undefined.

resume_interval(type) -> emqx_schema:duration_ms();
resume_interval(desc) -> ?DESC("resume_interval");
resume_interval(default) -> ?RESUME_INTERVAL;
resume_interval(required) -> false;
resume_interval(_) -> undefined.

async_inflight_window(type) -> pos_integer();
async_inflight_window(desc) -> ?DESC("async_inflight_window");
async_inflight_window(default) -> ?DEFAULT_INFLIGHT;
async_inflight_window(required) -> false;
async_inflight_window(_) -> undefined.

batch_size(type) -> pos_integer();
batch_size(desc) -> ?DESC("batch_size");
batch_size(default) -> ?DEFAULT_BATCH_SIZE;
batch_size(required) -> false;
batch_size(_) -> undefined.

batch_time(type) -> emqx_schema:duration_ms();
batch_time(desc) -> ?DESC("batch_time");
batch_time(default) -> ?DEFAULT_BATCH_TIME;
batch_time(required) -> false;
batch_time(_) -> undefined.

queue_max_bytes(type) -> emqx_schema:bytesize();
queue_max_bytes(desc) -> ?DESC("queue_max_bytes");
queue_max_bytes(default) -> ?DEFAULT_QUEUE_SIZE;
queue_max_bytes(required) -> false;
queue_max_bytes(_) -> undefined.
