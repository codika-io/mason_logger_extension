# Enhancing CLI Development: Introducing Mason Logger Extension

Hello! I'm the founder of [codika.io](https://codika.io), where we're dedicated to creating powerful tools that make Flutter developers' lives easier. Today, I'm excited to share my first Medium article and introduce our latest contribution to the Flutter community.

## The Journey

While developing Codika, our CLI tool for automated Flutter setup, we created numerous utilities and helper functions that proved invaluable in our development process. We realized these tools could benefit other developers building similar solutions. This realization led us to a decision: we would extract and open-source these utilities as standalone packages for the community.

## Introducing Mason Logger Extension

The first package in this series is Mason Logger Extension, which enhances the capabilities of the popular `mason_logger` package. If you're familiar with Dart CLI development, you probably know that Mason Logger, created by Felix Angelov, provides an excellent foundation for terminal interaction. It's clean, efficient, and purposefully unopinionated.

However, through our journey with Codika, we found ourselves repeatedly implementing additional formatting and visual elements to enhance our CLI's user experience. We've packaged these enhancements into Mason Logger Extension, making them available to everyone who wants to create more visually appealing and user-friendly CLIs.

## Let's See It in Action

The best way to understand what Mason Logger Extension brings to the table is through examples. Let's look at four key features that showcase its capabilities.

### 1. Beautiful Framed Messages

When you need to highlight important information, frames can make your message stand out:

```dart
void main() {
  final logger = Logger();
  
  logger.sectionTitle('Welcome to Mason Logger Extension');
}
```

This produces an elegant framed output:
