class MetaHeader {
  final String nomeMeta;
  final String nomeVendedor;
  final String diasUteis;
  final String diasDecorridos;
  final String diasRestantes;

  final String dataInicio;
  final String dataFim;

  MetaHeader(this.nomeMeta, this.nomeVendedor, this.diasUteis,
      this.diasDecorridos, this.diasRestantes, this.dataInicio, this.dataFim);

  factory MetaHeader.sample() {
    return MetaHeader('Meta Teste', 'nome vendedor', '21', '14', '7',
        '01/08/2022', '31/08/2022');
  }
}
