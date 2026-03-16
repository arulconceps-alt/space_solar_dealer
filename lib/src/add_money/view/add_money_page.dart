import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_solar_dealer/src/add_money/bloc/add_money_bloc.dart';
import 'package:space_solar_dealer/src/add_money/repo/add_money_repository.dart';
import 'package:space_solar_dealer/src/add_money/view/widgets/amount_chip.dart';
import 'package:space_solar_dealer/src/add_money/view/widgets/input_field_with_title_cta.dart';
import 'package:space_solar_dealer/src/add_money/view/widgets/promo_card_widget.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';
import 'package:space_solar_dealer/src/common/widgets/default_top_navigation_bar.dart';
import 'package:go_router/go_router.dart';

class AddMoneyPage extends StatefulWidget {
  const AddMoneyPage({super.key});

  @override
  State<AddMoneyPage> createState() => _AddMoneyPageState();
}

class _AddMoneyPageState extends State<AddMoneyPage> {
  late final TextEditingController _amountController;
  late final TextEditingController _promoController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _promoController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AddMoneyBloc(repository: AddMoneyRepository())
            ..add(const InitializeAddMoney()),
      child: Scaffold(
        backgroundColor: const Color(0xFF141318),
        appBar: DefaultTopNavigationBar(
          title: 'Add Money',
          onBackTap: () => context.pop(),
        ),
        body: BlocListener<AddMoneyBloc, AddMoneyState>(
          listener: (context, state) {
            if (state.status == AddMoneyStatus.failure &&
                state.message.isNotEmpty) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state.status == AddMoneyStatus.success) {
              context.pushNamed(RouteName.paymentModePage);
            }
            if (state.amount != _amountController.text) {
              _amountController.text = state.amount;
            }
            if (state.promoCode != _promoController.text) {
              _promoController.text = state.promoCode;
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: BlocBuilder<AddMoneyBloc, AddMoneyState>(
              builder: (context, state) {
                final bloc = context.read<AddMoneyBloc>();
                return Column(
                  children: [
                    _buildAmountSelectionCard(bloc, state),
                    const SizedBox(height: 32),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Apply Promo Code',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    InputfieldWithTitleCta(
                      controller: _promoController,
                      onApply: () => bloc.add(const ApplyPromo()),
                    ),
                    const SizedBox(height: 16),
                    ...state.promos.map(
                      (promo) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: PromoCardWidget(
                          code: promo.code,
                          description: promo.description,
                          minDeposit: promo.minDeposit,
                          validity: promo.validity,
                          onApply: () =>
                              bloc.add(UpdatePromoCode(promoCode: promo.code)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAmountSelectionCard(AddMoneyBloc bloc, AddMoneyState state) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 328.42),
      padding: const EdgeInsets.all(14.60),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SELECT AMOUNT',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.95,
              letterSpacing: 0.88,
            ),
          ),
          const SizedBox(height: 14.60),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: state.quickAmounts.map((amt) {
                return Padding(
                  padding: const EdgeInsets.only(right: 14.60),
                  child: AmountChip(
                    label: amt,
                    isSelected: state.selectedAmount == amt,
                    onTap: () => bloc.add(SelectQuickAmount(amount: amt)),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14.60),
          _buildAmountField(bloc),
          const SizedBox(height: 21.89),
          Center(child: _buildProceedButton(bloc, state)),
        ],
      ),
    );
  }

  Widget _buildAmountField(AddMoneyBloc bloc) {
    return Container(
      height: 43.79,
      padding: const EdgeInsets.symmetric(horizontal: 10.95),
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        borderRadius: BorderRadius.circular(7.30),
      ),
      child: TextField(
        controller: _amountController,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white, fontSize: 14.60),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter amount',
          hintStyle: TextStyle(color: Colors.white54),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
        onChanged: (value) => bloc.add(UpdateAmount(amount: value)),
      ),
    );
  }

  Widget _buildProceedButton(AddMoneyBloc bloc, AddMoneyState state) {
    final isLoading = state.status == AddMoneyStatus.submitting;
    return GestureDetector(
      onTap: isLoading ? null : () => bloc.add(const ProceedToPay()),
      child: Container(
        width: 299.23,
        height: 43.79,
        decoration: BoxDecoration(
          gradient: isLoading
              ? null
              : const LinearGradient(
                  colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
                ),
          color: isLoading ? Colors.grey : null,
          borderRadius: BorderRadius.circular(7.30),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
                  'Proceed to Pay',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.60,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
