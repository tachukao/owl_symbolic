.PHONY: all
all: build

.PHONY: depend depends
depend depends:
	dune external-lib-deps --missing @install @runtest

.PHONY: build
build: depends
	dune build @install

.PHONY: test
test: depends
	dune runtest -j 1 --no-buffer -p owl-onnx

.PHONY: clean
clean:
	dune clean

.PHONY: install
install: build
	dune install

.PHONY: uninstall
uninstall:
	dune uninstall
	$(RM) $(OPAM_STUBS)/dllowl_stubs.so
	$(RM) $(OPAM_STUBS)/dllowl_opencl_stubs.so

.PHONY: doc
doc:
	opam install -y odoc
	dune build @doc

push:
	git commit -am "coding onnx converter ..." && \
	git push origin `git branch | grep \* | cut -d ' ' -f2`