import 'dart:math';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum LoadingSkeletonType { box, circle, profile, card, text, description }

class LoadingWidgetSkeleton extends StatelessWidget {
  final double itemWidth;
  final double itemHeight;
  final BorderRadius? borderRadius;
  final int itemCount;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Axis scrollDirection;
  final bool shimmer;
  final LoadingSkeletonType type;

  final Color? color;
  final Alignment alignment;

  const LoadingWidgetSkeleton({
    super.key,
    this.itemWidth = 100,
    this.itemHeight = 100,
    this.borderRadius,
    this.itemCount = 7,
    this.padding = const EdgeInsets.all(20),
    this.margin,
    this.scrollDirection = Axis.horizontal,
    this.shimmer = true,
    this.type = LoadingSkeletonType.box,
    this.color,
    this.alignment = Alignment.centerLeft,
  });

  Color get _effectiveColor => color ?? Colors.grey[300]!;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: SizedBox(
        width: itemWidth,
        height: itemHeight,
        child: Align(
          alignment: alignment,
          child: Skeletonizer(
            enabled: true,
            effect: shimmer
                ? const ShimmerEffect(duration: Duration(milliseconds: 1200))
                : null,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: padding,
              scrollDirection: scrollDirection,
              itemCount: itemCount,
              separatorBuilder: (_, __) => const SizedBox(width: 16, height: 16),
              itemBuilder: (_, __) => _buildDetailsLoadingSkeletonType(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsLoadingSkeletonType() {
    switch (type) {
      case LoadingSkeletonType.circle:
        return _circleSkeleton();
      case LoadingSkeletonType.profile:
        return _profileSkeleton();
      case LoadingSkeletonType.card:
        return _cardSkeleton();
      case LoadingSkeletonType.text:
        return _textSkeleton();
      case LoadingSkeletonType.description:
        return _descriptionSkeleton();
      default:
        return _boxSkeleton();
    }
  }

  Widget _boxSkeleton() {
    return Align(
      alignment: alignment,
      child: Skeleton.shade(
        child: Container(
          width: itemWidth,
          height: itemHeight,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: _effectiveColor,
          ),
        ),
      ),
    );
  }

  Widget _circleSkeleton() {
    return Align(
      alignment: alignment,
      child: Skeleton.shade(
        child: Container(
          width: itemWidth,
          height: itemWidth,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _effectiveColor,
          ),
        ),
      ),
    );
  }

  Widget _profileSkeleton() {
    return Align(
      alignment: alignment,
      child: Skeleton.shade(
        child: SizedBox(
          width: itemWidth,
          child: Column(
            crossAxisAlignment: _alignmentToCrossAxis(),
            children: [
              Container(
                width: itemWidth * 0.6,
                height: itemWidth * 0.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _effectiveColor,
                ),
              ),
              const SizedBox(height: 10),
              _textLine(width: itemWidth * 0.8),
              const SizedBox(height: 6),
              _textLine(width: itemWidth * 0.5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardSkeleton() {
    return Align(
      alignment: alignment,
      child: Skeleton.shade(
        child: SizedBox(
          width: itemWidth,
          child: Column(
            crossAxisAlignment: _alignmentToCrossAxis(),
            children: [
              Container(
                height: itemHeight * 0.7,
                width: itemWidth,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: _effectiveColor,
                ),
              ),
              const SizedBox(height: 10),
              _textLine(width: itemWidth * 0.8),
              const SizedBox(height: 5),
              _textLine(width: itemWidth * 0.5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textSkeleton() {
    return Align(
      alignment: alignment,
      child: Skeleton.shade(
        child: Column(
          crossAxisAlignment: _alignmentToCrossAxis(),
          children: List.generate(
            itemCount,
            (_) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: _textLine(
                width: itemWidth + Random().nextInt(10),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _descriptionSkeleton() {
    return Align(
      alignment: alignment,
      child: Skeleton.shade(
        child: SizedBox(
          width: itemWidth,
          child: Column(
            crossAxisAlignment: _alignmentToCrossAxis(),
            children: [
              _textLine(width: itemWidth),
              const SizedBox(height: 8),
              _textLine(width: itemWidth * 0.95),
              const SizedBox(height: 8),
              _textLine(width: itemWidth * 0.85),
              const SizedBox(height: 8),
              _textLine(width: itemWidth * 0.70),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textLine({required double width}) {
    return Container(
      width: width,
      height: 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: _effectiveColor,
      ),
    );
  }

  CrossAxisAlignment _alignmentToCrossAxis() {
    if (alignment == Alignment.centerRight) return CrossAxisAlignment.end;
    if (alignment == Alignment.centerLeft) return CrossAxisAlignment.start;
    return CrossAxisAlignment.center;
  }
}
