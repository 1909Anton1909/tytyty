from flask import Blueprint, request, jsonify
from playhouse.shortcuts import model_to_dict
from models import User, Role, database
from werkzeug.security import generate_password_hash, check_password_hash
from decorators import role_required

# Создаем Blueprint для пользователей
users_bp = Blueprint('users', __name__)

# Роли системы
ROLES = {
    'admin': 1,
    'technician': 2,
    'user': 3
}


@users_bp.route('/api/users', methods=['GET'])
@role_required(['admin'])
def get_all_users():
    """
    Получение списка всех пользователей.
    Доступно только администратору.
    """
    try:
        users = User.select().execute()
        users_list = [model_to_dict(user) for user in users]
        return jsonify(users_list), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500


@users_bp.route('/api/users/<int:user_id>', methods=['GET'])
@role_required(['admin', 'technician'])
def get_user_by_id(user_id):
    """
    Получение информации о конкретном пользователе по ID.
    Доступно администратору и техникам.
    """
    try:
        user = User.get_or_none(User.id == user_id)
        if not user:
            return jsonify({'error': 'Пользователь не найден'}), 404
        return jsonify(model_to_dict(user)), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500


@users_bp.route('/api/users', methods=['POST'])
@role_required(['admin'])
def create_user():
    """
    Создание нового пользователя.
    Доступно только администратору.
    """
    try:
        data = request.get_json()
        required_fields = ['username', 'password', 'email', 'role_id']

        # Проверка обязательных полей
        for field in required_fields:
            if field not in data:
                return jsonify({'error': f'Отсутствует обязательное поле: {field}'}), 400

        # Проверка уникальности username и email
        if User.select().where(User.username == data['username']).exists():
            return jsonify({'error': 'Пользователь с таким логином уже существует'}), 400

        if User.select().where(User.email == data['email']).exists():
            return jsonify({'error': 'Пользователь с таким email уже существует'}), 400

        # Хеширование пароля
        hashed_password = generate_password_hash(data['password'])

        # Создание пользователя
        user = User.create(
            username=data['username'],
            password_hash=hashed_password,
            email=data['email'],
            role_id=data['role_id'],
            is_active=True
        )

        return jsonify(model_to_dict(user)), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500


@users_bp.route('/api/users/<int:user_id>', methods=['PUT'])
@role_required(['admin'])
def update_user(user_id):
    """
    Обновление данных пользователя.
    Доступно только администратору.
    """
    try:
        user = User.get_or_none(User.id == user_id)
        if not user:
            return jsonify({'error': 'Пользователь не найден'}), 404

        data = request.get_json()

        # Обновление полей
        if 'username' in data and data['username'] != user.username:
            if User.select().where(User.username == data['username']).exists():
                return jsonify({'error': 'Пользователь с таким логином уже существует'}), 400
            user.username = data['username']

        if 'email' in data and data['email'] != user.email:
            if User.select().where(User.email == data['email']).exists():
                return jsonify({'error': 'Пользователь с таким email уже существует'}), 400
            user.email = data['email']

        if 'password' in data:
            user.password_hash = generate_password_hash(data['password'])

        if 'role_id' in data:
            user.role_id = data['role_id']

        if 'is_active' in data:
            user.is_active = data['is_active']

        user.save()
        return jsonify(model_to_dict(user)), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500


@users_bp.route('/api/users/<int:user_id>', methods=['DELETE'])
@role_required(['admin'])
def delete_user(user_id):
    """
    Удаление пользователя (мягкое удаление - деактивация).
    Доступно только администратору.
    """
    try:
        user = User.get_or_none(User.id == user_id)
        if not user:
            return jsonify({'error': 'Пользователь не найден'}), 404

        user.is_active = False
        user.save()
        return jsonify({'message': 'Пользователь деактивирован'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500


@users_bp.route('/api/users/<int:user_id>/tickets', methods=['GET'])
@role_required(['admin', 'technician'])
def get_user_tickets(user_id):
    """
    Получение всех заявок конкретного пользователя.
    Доступно администратору и техникам.
    """
    try:
        user = User.get_or_none(User.id == user_id)
        if not user:
            return jsonify({'error': 'Пользователь не найден'}), 404

        tickets = user.tickets.execute()
        tickets_list = [model_to_dict(ticket) for ticket in tickets]
        return jsonify(tickets_list), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500