import 'package:equatable/equatable.dart';
import 'package:vendas_gerenciamento/model/model.dart';

class VendaState extends Equatable {
  final Venda? venda;
  final List<Abatimento> abatimentosDaVenda;
  final bool carregando;

  const VendaState(this.venda, this.abatimentosDaVenda, this.carregando);

  const VendaState.initial({
    this.venda,
    this.abatimentosDaVenda = const [],
    this.carregando = false,
  });

  VendaState copyWith({
    Venda? venda,
    List<Abatimento>? abatimentosDaVenda,
    bool? carregando,
  }) {
    return VendaState(
      venda ?? this.venda,
      abatimentosDaVenda ?? this.abatimentosDaVenda,
      carregando ?? this.carregando,
    );
  }

  @override
  List<Object?> get props => [venda, abatimentosDaVenda, carregando];
}
