# #!/usr/bin/python3
# """
# Gerenciador de Tarefas e Cronograma para Polybar
# """
# import argparse
# import json
# import os
# from datetime import datetime
# import pgi
#
# pgi.require_version('Notify', '0.7')
# from pgi.repository import Notify
#
# Notify.init("Task Switcher")
#
# # Diretórios e arquivos persistentes
# SCRIPT_PATH = os.path.realpath(__file__)
# STATE_FILE = os.path.expanduser("~/.current_task.json")
# LOG_FILE = os.path.expanduser("~/.task_logs.log")
# MENU_STATE = os.path.expanduser("~/.task_menu_open")
#
# TASKS = ["Socialdroids", "Doutorado", "Pessoais", "SDTech"]
# COLORS = {
#     "Socialdroids": "#BD93F9", # Roxo
#     "Doutorado": "#F1FA8C",    # Amarelo
#     "Pessoais": "#50FA7B",     # Verde
#     "SDTech": "#8BE9FD"        # Azul
# }
# ICON_PATH = "/usr/share/icons/Yaru/48x48/apps/org.gnome.Calendar.png" # Ajuste se necessário
#
# # Mapeamento do cronograma baseado na image_b34e66.png
# # Formato: Dia da semana (0=Segunda ... 4=Sexta): [(Hora, Minuto, "Tarefa")]
# SCHEDULE = {
#     0: [(8,0,"Pessoais"), (10,0,"Socialdroids"), (13,30,"Pessoais"), (14,0,"Socialdroids"), (20,0,"Doutorado"), (21,0,"Pessoais")],
#     1: [(8,0,"Pessoais"), (9,0,"Doutorado"), (13,30,"Pessoais"), (14,0,"Doutorado"), (20,0,"Pessoais")],
#     2: [(8,0,"Pessoais"), (10,0,"Socialdroids"), (13,30,"Pessoais"), (14,0,"Socialdroids"), (19,0,"SDTech"), (20,0,"Doutorado"), (21,0,"Pessoais")],
#     3: [(8,0,"Pessoais"), (10,0,"Socialdroids"), (13,30,"Pessoais"), (14,0,"Socialdroids"), (18,0,"SDTech"), (20,0,"Pessoais")],
#     4: [(8,0,"Pessoais"), (10,0,"Socialdroids"), (13,30,"Pessoais"), (14,0,"Socialdroids"), (15,0,"SDTech"), (16,0,"Doutorado"), (20,0,"Pessoais")]
# }
#
# def get_current_state():
#     if os.path.exists(STATE_FILE):
#         with open(STATE_FILE, 'r') as f:
#             return json.load(f)
#     # Estado inicial padrão
#     now_str = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
#     return {"task": "Pessoais", "start": now_str}
#
# def save_state(state):
#     with open(STATE_FILE, 'w') as f:
#         json.dump(state, f)
#
# def log_task(old_task, start_time, end_time):
#     with open(LOG_FILE, 'a') as f:
#         f.write(f"[{start_time} -> {end_time}] Tarefa: {old_task}\n")
#
# def get_time_remaining():
#     now = datetime.now()
#     day = now.weekday()
#     
#     # Se for fim de semana, consideramos livre/pessoal
#     if day > 4:
#         return "Livre"
#         
#     current_schedule = SCHEDULE.get(day, [])
#     next_block_time = None
#     
#     for h, m, t in current_schedule:
#         block_time = now.replace(hour=h, minute=m, second=0, microsecond=0)
#         if block_time > now:
#             next_block_time = block_time
#             break
#             
#     if next_block_time:
#         diff = next_block_time - now
#         hours, remainder = divmod(diff.seconds, 3600)
#         minutes, _ = divmod(remainder, 60)
#         return f"{hours:02d}:{minutes:02d}"
#     else:
#         return "Livre" # Após as 21:00
#
# parser = argparse.ArgumentParser()
# parser.add_argument('-t', '--toggle', action='store_true', help="Abre/Fecha o menu")
# parser.add_argument('-s', '--switch', type=str, help="Muda para a tarefa especificada")
# args = parser.parse_args()
#
# state = get_current_state()
#
# # Ação: Alternar Tarefa
# if args.switch:
#     if args.switch == state["task"]:
#         notification = Notify.Notification.new("Aviso de Tarefa", f"Você já está na tarefa {args.switch}!", ICON_PATH)
#         notification.set_urgency(1)
#         notification.show()
#     elif args.switch in TASKS:
#         now_str = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
#         log_task(state["task"], state["start"], now_str)
#         save_state({"task": args.switch, "start": now_str})
#         
#         notification = Notify.Notification.new("Tarefa Alterada", f"Iniciando: {args.switch}", ICON_PATH)
#         notification.show()
#         
#         # Fecha o menu após escolher
#         if os.path.exists(MENU_STATE):
#             os.remove(MENU_STATE)
#     exit(0)
#
# # Ação: Abrir/Fechar Menu
# if args.toggle:
#     if os.path.exists(MENU_STATE):
#         os.remove(MENU_STATE)
#     else:
#         open(MENU_STATE, 'w').close()
#     exit(0)
#
# # Saída para o Polybar (Nenhum argumento passado)
# if os.path.exists(MENU_STATE):
#     # Constrói o menu clicável
#     menu_items = []
#     for t in TASKS:
#         color = COLORS.get(t, "#FFFFFF")
#         menu_items.append(f"%{{A1:python3 {SCRIPT_PATH} -s {t}:}}%{{F{color}}}{t}%{{F-}}%{{A}}")
#     
#     menu_str = " | ".join(menu_items)
#     # Botão de fechar menu
#     menu_str += f" %{{A1:python3 {SCRIPT_PATH} -t:}}|%{{F#ff5555}}   %{{F-}}%{{A}}"
#     print(menu_str)
# else:
#     # Exibe a tarefa atual e o tempo restante do bloco
#     current_task = state["task"]
#     color = COLORS.get(current_task, "#FFFFFF")
#     time_left = get_time_remaining()
#     
#     # Ao clicar, abre o menu (-t)
#     print(f"%{{A1:python3 {SCRIPT_PATH} -t:}}%{{F{color}}}󰥔 {current_task}: {time_left}%{{F-}}%{{A}}")
#
    #-----------------------------------------
#!/usr/bin/python3
"""
Gerenciador de Tarefas e Cronograma para Polybar
"""
import argparse
import json
import os
from datetime import datetime, timedelta
import pgi

pgi.require_version('Notify', '0.7')
from pgi.repository import Notify

Notify.init("Task Switcher")

# Diretórios e arquivos persistentes
SCRIPT_PATH = os.path.realpath(__file__)
STATE_FILE = os.path.expanduser("~/.current_task.json")
LOG_FILE = os.path.expanduser("~/.task_logs.log")
MENU_STATE = os.path.expanduser("~/.task_menu_open")

TASKS = ["Socialdroids", "Doutorado", "Pessoais", "SDTech"]
COLORS = {
    "Socialdroids": "#BD93F9", # Roxo
    "Doutorado": "#F1FA8C",    # Amarelo
    "Pessoais": "#50FA7B",     # Verde
    "SDTech": "#8BE9FD"        # Azul
}
ICON_PATH = "/usr/share/icons/Yaru/48x48/apps/org.gnome.Calendar.png"

# Mapeamento do cronograma (Hora, Minuto, "Tarefa")
SCHEDULE = {
    0: [(8,0,"Pessoais"), (10,0,"Socialdroids"), (13,30,"Pessoais"), (14,0,"Socialdroids"), (20,0,"Doutorado"), (21,0,"Pessoais")],
    1: [(8,0,"Pessoais"), (9,0,"Doutorado"), (13,30,"Pessoais"), (14,0,"Doutorado"), (20,0,"Pessoais")],
    2: [(8,0,"Pessoais"), (10,0,"Socialdroids"), (13,30,"Pessoais"), (14,0,"Socialdroids"), (19,0,"SDTech"), (20,0,"Doutorado"), (21,0,"Pessoais")],
    3: [(8,0,"Pessoais"), (10,0,"Socialdroids"), (13,30,"Pessoais"), (14,0,"Socialdroids"), (18,0,"SDTech"), (20,0,"Pessoais")],
    4: [(8,0,"Pessoais"), (10,0,"Socialdroids"), (13,30,"Pessoais"), (14,0,"Socialdroids"), (15,0,"SDTech"), (16,0,"Doutorado"), (20,0,"Pessoais")]
}

def get_current_state():
    if os.path.exists(STATE_FILE):
        with open(STATE_FILE, 'r') as f:
            try:
                return json.load(f)
            except json.JSONDecodeError:
                pass
    now_str = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    return {
        "task": "Pessoais", 
        "start": now_str,
        "last_off_schedule_warning": None,
        "last_transition_warning_task": None
    }

def save_state(state):
    with open(STATE_FILE, 'w') as f:
        json.dump(state, f)

def log_task(old_task, start_time, end_time):
    with open(LOG_FILE, 'a') as f:
        f.write(f"[{start_time} -> {end_time}] Tarefa: {old_task}\n")

def get_scheduled_task(now):
    day = now.weekday()
    if day > 4:
        return "Livre"
        
    current_schedule = SCHEDULE.get(day, [])
    active_task = "Livre"
    
    for h, m, t in current_schedule:
        block_time = now.replace(hour=h, minute=m, second=0, microsecond=0)
        if now >= block_time:
            active_task = t
        else:
            break
            
    return active_task

def get_time_remaining(now):
    day = now.weekday()
    if day > 4:
        return "Livre"
        
    current_schedule = SCHEDULE.get(day, [])
    next_block_time = None
    
    for h, m, t in current_schedule:
        block_time = now.replace(hour=h, minute=m, second=0, microsecond=0)
        if block_time > now:
            next_block_time = block_time
            break
            
    if next_block_time:
        diff = next_block_time - now
        hours, remainder = divmod(diff.seconds, 3600)
        minutes, _ = divmod(remainder, 60)
        return f"{hours:02d}:{minutes:02d}"
    else:
        return "Livre"

def process_notifications(state, now):
    scheduled_task = get_scheduled_task(now)
    current_task = state.get("task")
    state_changed = False

    # 1. Aviso de que o tempo da tarefa acabou (Transição)
    last_transition_task = state.get("last_transition_warning_task")
    if scheduled_task != "Livre" and scheduled_task != last_transition_task:
        notification = Notify.Notification.new(
            "⏳ Tempo Esgotado!", 
            f"O tempo do bloco anterior acabou. Mude sua tarefa para: {scheduled_task}", 
            ICON_PATH
        )
        notification.set_urgency(2) # Urgência Crítica
        notification.show()
        
        state["last_transition_warning_task"] = scheduled_task
        state_changed = True

    # 2. Aviso de desvio do cronograma (a cada 5 minutos)
    if current_task != scheduled_task and scheduled_task != "Livre":
        last_warning_str = state.get("last_off_schedule_warning")
        should_warn = False
        
        if not last_warning_str:
            should_warn = True
        else:
            last_warning_time = datetime.strptime(last_warning_str, "%Y-%m-%d %H:%M:%S")
            if (now - last_warning_time).total_seconds() >= 300: # 300s = 5 minutos
                should_warn = True
                
        if should_warn:
            notification = Notify.Notification.new(
                "⚠️ Fora do Cronograma", 
                f"Você está marcando '{current_task}', mas seu cronograma indica '{scheduled_task}'.", 
                ICON_PATH
            )
            notification.set_urgency(1)
            notification.show()
            
            state["last_off_schedule_warning"] = now.strftime("%Y-%m-%d %H:%M:%S")
            state_changed = True

    if state_changed:
        save_state(state)


parser = argparse.ArgumentParser()
parser.add_argument('-t', '--toggle', action='store_true', help="Abre/Fecha o menu")
parser.add_argument('-s', '--switch', type=str, help="Muda para a tarefa especificada")
args = parser.parse_args()

state = get_current_state()
now = datetime.now()

# Ação: Alternar Tarefa
if args.switch:
    if args.switch == state["task"]:
        notification = Notify.Notification.new("Aviso", f"Você já está na tarefa {args.switch}!", ICON_PATH)
        notification.set_urgency(1)
        notification.show()
    elif args.switch in TASKS:
        now_str = now.strftime("%Y-%m-%d %H:%M:%S")
        log_task(state["task"], state["start"], now_str)
        
        # Atualiza o estado e reseta o aviso de desvio para não spammar imediatamente
        state["task"] = args.switch
        state["start"] = now_str
        state["last_off_schedule_warning"] = None 
        save_state(state)
        
        notification = Notify.Notification.new("Tarefa Alterada", f"Iniciando: {args.switch}", ICON_PATH)
        notification.show()
        
        if os.path.exists(MENU_STATE):
            os.remove(MENU_STATE)
    exit(0)

# Ação: Abrir/Fechar Menu
if args.toggle:
    if os.path.exists(MENU_STATE):
        os.remove(MENU_STATE)
    else:
        open(MENU_STATE, 'w').close()
    exit(0)

# Saída padrão para o Polybar e checagem de notificações
process_notifications(state, now)

if os.path.exists(MENU_STATE):
    menu_items = []
    for t in TASKS:
        color = COLORS.get(t, "#FFFFFF")
        menu_items.append(f"%{{A1:python3 {SCRIPT_PATH} -s {t}:}}%{{F{color}}}{t}%{{F-}}%{{A}}")
    
    menu_str = " | ".join(menu_items)
    menu_str += f" %{{A1:python3 {SCRIPT_PATH} -t:}}|%{{F#ff5555}}   %{{F-}}%{{A}}"
    print(menu_str)
else:
    current_task = state["task"]
    color = COLORS.get(current_task, "#FFFFFF")
    time_left = get_time_remaining(now)
    
    print(f"%{{A1:python3 {SCRIPT_PATH} -t:}}%{{F{color}}}󰥔 {current_task}: {time_left}%{{F-}}%{{A}}")
