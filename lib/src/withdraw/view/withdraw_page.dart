import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';
import 'package:space_solar_dealer/src/withdraw/bloc/withdraw_bloc.dart';
import 'package:space_solar_dealer/src/withdraw/repo/withdraw_repository.dart';
import 'package:space_solar_dealer/src/withdraw/view/widgets/withdraw_widgets.dart';
import 'package:go_router/go_router.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: WithdrawState.initial.amount,
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WithdrawBloc(repository: WithdrawRepository()),
      child: Scaffold(
        backgroundColor: const Color(0xFF1C1B20),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Withdraw',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: BlocBuilder<WithdrawBloc, WithdrawState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  if (state.status == WithdrawStatus.reviewing) {
                    context.read<WithdrawBloc>().add(const EditWithdraw());
                  } else {
                    Navigator.pop(context);
                  }
                },
              );
            },
          ),
        ),
        body: BlocListener<WithdrawBloc, WithdrawState>(
          listener: (context, state) {
            if (state.status == WithdrawStatus.failure &&
                state.message.isNotEmpty) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state.status == WithdrawStatus.success) {
              context.goNamed(RouteName.withdrawSuccessful);
            }
            if (state.amount != _amountController.text) {
              _amountController.text = state.amount;
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<WithdrawBloc, WithdrawState>(
                builder: (context, state) {
                  final bloc = context.read<WithdrawBloc>();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.status != WithdrawStatus.reviewing) ...[
                        const Text(
                          'Select Payment',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),

                        PaymentMethodTile(
                          title: 'UPI ID',
                          isSelected: state.selectedMethod == 'upi',
                          icon: Image.asset(
                            'assets/gpay_logo.png',
                            width: 20,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.payment, size: 20),
                          ),
                          onTap: () => bloc.add(
                            const SelectWithdrawMethod(
                              method: 'upi',
                              displayInfo: 'UPI: user@okhdfcbank',
                            ),
                          ),
                          child: WithdrawUpiForm(
                            upiId: 'user@okhdfcbank',
                            onRedeem: () => bloc.add(const RedeemWithdraw()),
                            onEdit: () => bloc.add(const EditWithdraw()),
                          ),
                        ),
                        const SizedBox(height: 16),

                        PaymentMethodTile(
                          title: 'Amazon Pay',
                          isSelected: state.selectedMethod == 'amazon',
                          icon: Image.asset(
                            'assets/amazon_logo.png',
                            width: 20,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.shop, size: 20),
                          ),
                          onTap: () => bloc.add(
                            const SelectWithdrawMethod(
                              method: 'amazon',
                              displayInfo: 'Amazon Pay: 6546515616',
                            ),
                          ),
                          child: WithdrawAmazonForm(
                            phoneNumber: '6546515616',
                            onRedeem: () => bloc.add(const RedeemWithdraw()),
                            onEdit: () => bloc.add(const EditWithdraw()),
                          ),
                        ),
                        const SizedBox(height: 16),

                        PaymentMethodTile(
                          title: 'Bank Details',
                          isSelected: state.selectedMethod == 'bank',
                          icon: const Icon(
                            Icons.account_balance,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onTap: () => bloc.add(
                            const SelectWithdrawMethod(
                              method: 'bank',
                              displayInfo: 'Bank: ...89691',
                            ),
                          ),
                          child: WithdrawBankForm(
                            accountHolder: 'Praven Singh',
                            accountNo: '50100018489691',
                            ifscCode: 'HDFC0001033',
                            onRedeem: () => bloc.add(const RedeemWithdraw()),
                            onEdit: () => bloc.add(const EditWithdraw()),
                          ),
                        ),
                      ] else ...[
                        _buildSelectionHeader(state.displayInfo),
                        LayoutAddMoney(
                          amountController: _amountController,
                          balance: "1234",
                          onWithdraw: () {
                            bloc.add(const ConfirmWithdraw());
                          },
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionHeader(String info) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF34C759).withOpacity(0.4)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF34C759), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              info,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => context.read<WithdrawBloc>().add(const EditWithdraw()),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Edit",
                style: TextStyle(
                  color: Color(0xFFDFC45C),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
