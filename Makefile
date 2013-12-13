REBAR?=./rebar
PACKAGE=hackney

all: build

dev: devbuild

doc: dev
	$(REBAR) -C rebar_dev.config doc

clean:
	$(REBAR) clean

distclean: clean
	@rm -rf deps

build: deps
	$(REBAR) compile

deps:
	$(REBAR) get-deps


# development
#
devclean:
	$(REBAR) -C rebar_dev.config clean

devbuild: devdeps
	$(REBAR) -C rebar_dev.config compile

devdeps:
	$(REBAR) -C rebar_dev.config get-deps


.PHONY: doc deps

init_plt:
	dialyzer --build_plt --output_plt .$(PACKAGE).plt -pa deps/mimetypes --apps erts kernel stdlib crypto ssl public_key syntax_tools asn1 runtime_tools mnesia compiler mimetypes

dialyzer:
	dialyzer --plt .$(PACKAGE).plt --src  -r src
