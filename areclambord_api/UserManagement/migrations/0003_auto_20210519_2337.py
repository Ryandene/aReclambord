# Generated by Django 2.2.13 on 2021-05-19 18:07

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('UserManagement', '0002_dbusermodel'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='AReclamborUserModel',
            new_name='AReclamborProfileModel',
        ),
        migrations.RenameModel(
            old_name='DbUserModel',
            new_name='DbProfileModel',
        ),
    ]
