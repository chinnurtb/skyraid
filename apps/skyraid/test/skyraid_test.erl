-module(skyraid_test).

-include("skyraid.hrl").
%-compile([export_all]).

-include_lib("eunit/include/eunit.hrl").

-define(T(TestName), {atom_to_list(TestName), fun TestName/0}).

skyraid_test_() ->
	{setup, fun setup/0, fun teardown/1,
		[
			?T(register_normal),
			?T(login_normal),
			?T(login_invalid_password),
			?T(login_ivalid_username_password)
		] 
	}.

setup() ->
	skyraid:start().

teardown(_Any) ->
	skyraid:stop().

register_normal() ->
	User = #skr_user{username="Apa", 
				  password="test", 
				  display_name="ApaDisplay", 
				  email="adam@gmail.com"},
	?assertEqual(ok, skyraid:register(User)).

login_normal() ->
	{ok, _Session} = skyraid:login("Adam", "test").

login_invalid_password() ->
	?assertEqual({error, invalid_password}, skyraid:login("Adam", "sdfdsfdsf")).

login_ivalid_username_password() ->
	?assertEqual({error, invalid_uername_password}, skyraid:login("sdasd", "sdfdf")).	