MBR=mod_bot_relay
LC=libcarrier
EC=erlc
INC=-I /home/riley/carrierpigeon/ejabberd_src/ejabberd/src

all: $(MBR)

$(LC): $(LC).erl
	$(EC) $(INC) $(LC).erl

$(MBR): $(LC) $(MBR).erl
	$(EC) $(INC) $(MBR).erl

install: $(MBR)
	sudo cp $(MBR).beam /lib/ejabberd/ebin/$(MBR).beam

test: $(LC)
	erl -compile libcarrier_test
	erl -noshell -s libcarrier_test test_carrier -s init stop

restart: install
	sudo ejabberdctl restart

clean:
	rm -rf *.beam
