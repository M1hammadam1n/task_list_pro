import 'package:flutter/material.dart';
import 'package:maps_test/src/pages/settings/settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const Color backgroundColor = Color(0xFF1A1A2F);
  static const Color cardColor = Color(0xFF242443);
  static const Color accentColor = Color(0xFF673AB7);
  static const Color titleColor = Colors.white;
  static const Color subtitleColor = Colors.white70;
  static const Color primaryColor = Color(0xFF9C27B0);
  static const Color primaryColorLight = Color(0xFFE1BEE7);
  static const Color axisColor = Color(0x33FFFFFF);
  static const Color pendingColor = Color(0xFFBBBBBB);
  static const Color completedColor = Color(0xFF8A2BE2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            border: const Border(
              bottom: BorderSide(color: Color(0xFF7a12ff), width: 2),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 25,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=3',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Hello Joshitha',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Keep Plan For 1 Day',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.settings_suggest,
                      size: 35,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              _TaskProgressSection(),
              SizedBox(height: 30),
              _CompletionGraphSection(),
              SizedBox(height: 30),
              _TasksNext7DaysSection(),
              SizedBox(height: 30),
              _PendingCategoriesSection(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskProgressSection extends StatelessWidget {
  final int totalTasks = 20;
  final int completedTasks = 1;

  const _TaskProgressSection();

  @override
  Widget build(BuildContext context) {
    final int pendingTasks = totalTasks - completedTasks;
    final double completionPercentage = totalTasks > 0
        ? completedTasks / totalTasks
        : 0.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ProfilePage.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTotalTasksRing(completionPercentage),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusRow(
                  icon: Icons.more_horiz,
                  title: 'Pending',
                  count: pendingTasks,
                  color: ProfilePage.pendingColor,
                ),
                const SizedBox(height: 20),
                _buildStatusRow(
                  icon: Icons.check_circle_outline,
                  title: 'Completed',
                  count: completedTasks,
                  color: ProfilePage.completedColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalTasksRing(double completionPercentage) {
    return SizedBox(
      width: 90,
      height: 90,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(90, 90),
            painter: ProgressRingPainter(progress: completionPercentage),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '20',
                style: TextStyle(
                  color: ProfilePage.titleColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Total Tasks',
                style: TextStyle(color: ProfilePage.subtitleColor, fontSize: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow({
    required IconData icon,
    required String title,
    required int count,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Text(
          count < 10 ? '0$count' : '$count',
          style: const TextStyle(
            color: ProfilePage.titleColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ProgressRingPainter extends CustomPainter {
  final double progress;

  ProgressRingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 10.0;
    final radius = (size.width / 2) - strokeWidth / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final bgPaint = Paint()
      ..color = ProfilePage.accentColor.withOpacity(0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);
    final progressPaint = Paint()
      ..color = ProfilePage.accentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double sweepAngle = 2 * 3.1415926535 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.1415926535 / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _CompletionGraphSection extends StatelessWidget {
  const _CompletionGraphSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ProfilePage.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Completion Of Daily Tasks',
                style: TextStyle(
                  color: ProfilePage.titleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    color: ProfilePage.subtitleColor,
                    size: 14,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    '11-12-22',
                    style: TextStyle(
                      color: ProfilePage.subtitleColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    '17-12-22',
                    style: TextStyle(
                      color: ProfilePage.subtitleColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: ProfilePage.subtitleColor,
                    size: 14,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const AspectRatio(aspectRatio: 1.8, child: _TaskCompletionChart()),
        ],
      ),
    );
  }
}

class _TaskCompletionChart extends StatelessWidget {
  const _TaskCompletionChart();

  @override
  Widget build(BuildContext context) {
    final List<double> data = [5, 8, 4, 12, 6, 5, 5];
    final List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return CustomPaint(
      painter: _CompletionGraphPainter(data: data, days: days),
      child: Container(),
    );
  }
}

class _CompletionGraphPainter extends CustomPainter {
  final List<double> data;
  final List<String> days;
  final double maxValue = 12.0;
  final double graphPaddingTop = 15.0;

  _CompletionGraphPainter({required this.data, required this.days});

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height - graphPaddingTop;
    final double dayLabelHeight = 25.0;
    final double effectiveHeight = height - dayLabelHeight;
    final double stepX = width / (data.length - 1);

    final Paint gridPaint = Paint()
      ..color = ProfilePage.axisColor
      ..strokeWidth = 1.0;

    for (int i = 0; i < 4; i++) {
      final double y = effectiveHeight * (i / 3) + graphPaddingTop;
      canvas.drawLine(Offset(0, y), Offset(width, y), gridPaint);
    }

    final List<Offset> points = [];
    for (int i = 0; i < data.length; i++) {
      final double x = i * stepX;
      final double y =
          effectiveHeight -
          (data[i] / maxValue) * effectiveHeight +
          graphPaddingTop;
      points.add(Offset(x, y));
    }

    final Path fillPath = Path();
    fillPath.moveTo(points.first.dx, effectiveHeight + graphPaddingTop);
    fillPath.lineTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length - 1; i++) {
      final controlPointX1 = points[i].dx + stepX * 0.5;
      final controlPointY1 = points[i].dy;
      final controlPointX2 = points[i + 1].dx - stepX * 0.5;
      final controlPointY2 = points[i + 1].dy;

      fillPath.cubicTo(
        controlPointX1,
        controlPointY1,
        controlPointX2,
        controlPointY2,
        points[i + 1].dx,
        points[i + 1].dy,
      );
    }

    fillPath.lineTo(points.last.dx, effectiveHeight + graphPaddingTop);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          ProfilePage.primaryColor.withOpacity(0.5),
          ProfilePage.primaryColor.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, width, height));
    canvas.drawPath(fillPath, fillPaint);

    final Path linePath = Path();
    linePath.moveTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length - 1; i++) {
      final controlPointX1 = points[i].dx + stepX * 0.5;
      final controlPointY1 = points[i].dy;
      final controlPointX2 = points[i + 1].dx - stepX * 0.5;
      final controlPointY2 = points[i + 1].dy;
      linePath.cubicTo(
        controlPointX1,
        controlPointY1,
        controlPointX2,
        controlPointY2,
        points[i + 1].dx,
        points[i + 1].dy,
      );
    }

    final Paint linePaint = Paint()
      ..color = ProfilePage.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(linePath, linePaint);
    _drawHighlightZone(
      canvas,
      points[1].dx,
      points[1].dy,
      stepX,
      effectiveHeight,
      graphPaddingTop,
      8,
    );
    _drawHighlightZone(
      canvas,
      points[3].dx,
      points[3].dy,
      stepX,
      effectiveHeight,
      graphPaddingTop,
      12,
    );

    for (int i = 0; i < days.length; i++) {
      final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: days[i],
          style: const TextStyle(
            color: ProfilePage.subtitleColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      final x = i * stepX - textPainter.width / 2;
      final y = effectiveHeight + graphPaddingTop + 5;
      canvas.drawRect(
        Rect.fromLTWH(x, y, textPainter.width, textPainter.height),
        Paint()..color = ProfilePage.cardColor,
      );
      textPainter.paint(canvas, Offset(x, y));
    }
  }

  void _drawHighlightZone(
    Canvas canvas,
    double xCenter,
    double yCenter,
    double stepX,
    double effectiveHeight,
    double graphPaddingTop,
    int value,
  ) {
    final double zoneWidth = stepX * 0.8;
    final double zoneLeft = xCenter - zoneWidth / 2;
    final double zoneRight = xCenter + zoneWidth / 2;
    final double zoneBottom = effectiveHeight + graphPaddingTop;
    final Paint zonePaint = Paint()
      ..color = ProfilePage.primaryColor.withOpacity(0.15)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTRB(zoneLeft, graphPaddingTop, zoneRight, zoneBottom),
      zonePaint,
    );
    final Paint whiteDotPaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(xCenter, yCenter), 3, whiteDotPaint);
    final Paint ringPaint = Paint()
      ..color = ProfilePage.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawCircle(Offset(xCenter, yCenter), 6, ringPaint);
    final String labelText = '$value\nTasks';
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: labelText,
        style: const TextStyle(
          color: ProfilePage.titleColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final double labelY = yCenter + 15;
    final double labelX = xCenter - textPainter.width / 2;

    textPainter.paint(canvas, Offset(labelX, labelY));
  }

  @override
  bool shouldRepaint(covariant _CompletionGraphPainter oldDelegate) {
    return oldDelegate.data != data || oldDelegate.days != days;
  }
}

class _TasksNext7DaysSection extends StatelessWidget {
  const _TasksNext7DaysSection();

  final List<Map<String, dynamic>> _upcomingTasks = const [
    {
      'title': 'Taitile-1',
      'date': '14-12-22',
      'icon': Icons.tune,
      'color': Color(0xFF5F33E1),
    },
    {
      'title': 'Taitile-2',
      'date': '15-12-22',
      'icon': Icons.person,
      'color': Colors.orange,
    },
    {
      'title': 'Taitile-3',
      'date': '16-12-22',
      'icon': Icons.favorite,
      'color': Colors.green,
    },
    {
      'title': 'Taitile-4',
      'date': '17-12-22',
      'icon': Icons.work,
      'color': Colors.blue,
    },
    {
      'title': 'Taitile-5',
      'date': '18-12-22',
      'icon': Icons.home,
      'color': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tasks In Next 7 Days',
                style: TextStyle(
                  color: ProfilePage.titleColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.more_horiz,
                color: ProfilePage.subtitleColor,
                size: 24,
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 120,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: _upcomingTasks.length,
            itemBuilder: (context, index) {
              final task = _upcomingTasks[index];
              return _buildTaskCard(task);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ProfilePage.cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: (task['color'] as Color).withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              task['icon'] as IconData,
              color: task['color'] as Color,
              size: 20,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task['title'] as String,
                style: const TextStyle(
                  color: ProfilePage.titleColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                task['date'] as String,
                style: const TextStyle(
                  color: ProfilePage.subtitleColor,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PendingCategoriesSection extends StatelessWidget {
  const _PendingCategoriesSection();

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'Work', 'count': 1, 'color': Color(0xFF5F33E1)},
    {'name': 'Personal', 'count': 1, 'color': Colors.orange},
    {'name': 'Birthday', 'count': 1, 'color': Colors.pink},
    {'name': 'Wishlist', 'count': 1, 'color': Colors.green},
    {'name': 'No Category', 'count': 16, 'color': Colors.grey},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ProfilePage.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pending Tasks In Categories',
                style: TextStyle(
                  color: ProfilePage.titleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Text(
                    'In 30 Days',
                    style: TextStyle(
                      color: ProfilePage.subtitleColor,
                      fontSize: 14,
                    ),
                  ),
                  const Icon(
                    Icons.check_circle_outline,
                    color: ProfilePage.subtitleColor,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCategoryRing(),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _categories
                      .map((cat) => _buildCategoryItem(cat))
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRing() {
    return SizedBox(
      width: 90,
      height: 90,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(90, 90),
            painter: _CategoryRingPainter(categories: _categories),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '20',
                style: TextStyle(
                  color: ProfilePage.titleColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Total Tasks',
                style: TextStyle(color: ProfilePage.subtitleColor, fontSize: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: category['color'] as Color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                category['name'] as String,
                style: const TextStyle(
                  color: ProfilePage.subtitleColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Text(
            '${(category['count'] as int) < 10 ? '0' : ''}${category['count']}',
            style: const TextStyle(
              color: ProfilePage.titleColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryRingPainter extends CustomPainter {
  final List<Map<String, dynamic>> categories;

  _CategoryRingPainter({required this.categories});

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 10.0;
    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final Paint backgroundPaint = Paint()
      ..color = ProfilePage.cardColor.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius - strokeWidth / 2, backgroundPaint);
    final int totalTasks = categories.fold(
      0,
      (sum, cat) => sum + (cat['count'] as int),
    );

    double startAngle = -90.0;

    for (final category in categories) {
      final int count = category['count'] as int;
      final Color color = category['color'] as Color;
      final double sweepAngle = totalTasks > 0
          ? (count / totalTasks) * 360.0
          : 0.0;

      final Paint segmentPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
      final double startAngleRad = startAngle * (3.14159 / 180);
      final double sweepAngleRad = sweepAngle * (3.14159 / 180);

      if (sweepAngleRad > 0) {
        canvas.drawArc(
          rect.deflate(strokeWidth / 2),
          startAngleRad,
          sweepAngleRad,
          false,
          segmentPaint,
        );
      }

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _CategoryRingPainter oldDelegate) {
    if (oldDelegate.categories.length != categories.length) return true;
    for (int i = 0; i < categories.length; i++) {
      if (oldDelegate.categories[i]['count'] != categories[i]['count'] ||
          oldDelegate.categories[i]['color'] != categories[i]['color']) {
        return true;
      }
    }
    return false;
  }
}
